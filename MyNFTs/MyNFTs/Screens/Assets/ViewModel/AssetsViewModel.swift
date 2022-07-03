//
//  AssetsViewModel.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 25.06.22.
//

import SwiftUI

class AssetsViewModel: ObservableObject {
    
    var openSeaService: OpenSeaServiceProtocol
    var coinbaseService: CoinbaseServiceProtocol

    @Published var wallet =  UserDefaults.standard.string(forKey: "mywallet") ?? "0x1b584fc86390d7D83B529a4346330ee3D2061681"
    @Published var headerValues = HeaderValues()
    @Published var isSyncActive = false

    @Published var assets = [Asset]()
    @Published var error = ErrorInfo()
    
    init(openSeaService: OpenSeaServiceProtocol = OpenSeaService(),
         coinbaseService: CoinbaseServiceProtocol = CoinbaseService()) {
        
        self.openSeaService = openSeaService
        self.coinbaseService = coinbaseService
    }
    
    var sortedAssets: [Asset] {
        return assets
    }
    
    func startSync() {
        
        if !isSyncActive {
            
            isSyncActive = true
            headerValues.progress = 0.05
            
            getData() { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    
                    switch result {
                    case .success(let assets):
                        
                        self.assets = assets
                        self.getTotalValues(assets)
                    case .failure(let error):
                        
                        self.error.message = error.rawValue
                        break
                    }
                    
                    self.isSyncActive = false
                    self.headerValues.progress = 0.0
                }
            }
        }
        
    }
    
    func getData(completion: @escaping (Result<[Asset], OpenSeaError>) -> ()) {
        
        self.getAssets([], nil, wallet) {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let assets):
                self.getValues(assets) { finalAssets in
                    completion(.success(finalAssets))
                }
            case .failure(let error):
                
                completion(.failure(error))
                break
            }
        }
    }
    
    func getAssets(_ assets: [Asset], _ cursor: String?, _ wallet: String, completion: @escaping (Result<[Asset], OpenSeaError>) -> ()) {
        
        var currentAssets = assets
        
        openSeaService.getAssets(wallet, cursor) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                
                value.assets.forEach {
                    
                    if let id = $0.id,
                       let collectionSlug = $0.collection.slug,
                       let tokenId = $0.tokenId {
                        
                        let collectionName = $0.collection.name ?? collectionSlug
                        let collectionDescription = $0.collection.description ?? "Unknown description."
                        let collectionImageUrl = $0.collection.imageUrl ?? ""
                        
                        let nftName = $0.name ?? "#\(tokenId)"
                        let nftPermalink = $0.permalink ?? "https://opensea.io/collection/\(collectionSlug)"
                        let nftImageUrl = $0.imageUrl ?? ""
                        debugPrint(collectionImageUrl)
                        let newNFT = Asset.NFT(id: id,
                                               nftImageUrl: nftImageUrl,
                                               nftName: nftName,
                                               nftPermalink: nftPermalink)
                        
                        let newAsset = Asset(collectionSlug: collectionSlug,
                                             collectionName: collectionName,
                                             collectionImageUrl: collectionImageUrl,
                                             collectionDescription: collectionDescription,
                                             floorPrice: 0.0,
                                             averagePrice: 0.0,
                                             nfts: [newNFT])
                        
                        currentAssets.append(newAsset)
                    }
                }
                
                completion(.success(currentAssets))

            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
    
    func getValues(_ assets: [Asset], completion: @escaping ([Asset]) -> ()) {
        
        var updatedAssets = assets
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let semaphore = DispatchSemaphore(value: 0)
            
            for (i, asset) in updatedAssets.enumerated() {
                
                
                self.openSeaService.getCollection(asset.collectionSlug) { result in
                    if case .success(let value) = result {
                        
                        updatedAssets[i].floorPrice = round(100 * (Double(value.collection.stats.floorPrice ?? 0.0))) / 100
                        updatedAssets[i].averagePrice = round(100 * Double(value.collection.stats.averagePrice ?? 0.0)) / 100
                    }
                    semaphore.signal()
                }
                
                semaphore.wait()
            }
            
            completion(updatedAssets)
        }
    }
    
    func getTotalValues(_ assets: [Asset]) {
        
        let availableCurrencies = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "CHF"]
        
        var totalFloor = 0.0
        var totalAverage = 0.0
        
        assets.forEach {
            totalFloor += $0.floorPrice * Double($0.nfts.count)
            totalAverage += $0.averagePrice * Double($0.nfts.count)
        }
        
        DispatchQueue.main.async {
            self.headerValues.floor.eth = String(round(100 * totalFloor) / 100)
            self.headerValues.average.eth = String(round(100 * totalAverage) / 100)
        }
        
        let userCurrency = availableCurrencies.first(where: {$0 == Locale.current.currencyCode}) ?? "USD"
        
        coinbaseService.getFiatPrice(userCurrency) { [weak self] result in
            guard let self = self else { return }
            
            if case .success(let value) = result {
                
                let fiatPrice = Double(value.data.amount ?? "0.0") ?? 0.0
                
                DispatchQueue.main.async {
                    self.headerValues.floor.fiat = self.formatPrice(totalFloor * fiatPrice, userCurrency)
                    self.headerValues.average.fiat = self.formatPrice(totalAverage * fiatPrice, userCurrency)
                }
            }
        }
    }
    
    func formatPrice(_ amount : Double, _ currency: String) -> String {
        
        let localeSymbol = Locale
            .availableIdentifiers
            .lazy
            .map { Locale(identifier: $0) }
            .first { $0.currencyCode == currency }
        
        if let locale = localeSymbol {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = locale
            return formatter.string(from: NSNumber(value: amount))?.replacingOccurrences(of: "\u{00a0}", with: "") ?? String(amount)
        }
        
        return String(amount)
    }
}
