//
//  AddWalletViewModel.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

class AddWalletViewModel: ObservableObject {
    var openSeaService: OpenSeaServiceProtocol
    
    @Published var isLoading = false
    @Published var error = ErrorInfo()
    @Published var approvedWallet: String? = nil
    
    init(openSeaService: OpenSeaServiceProtocol = OpenSeaService()) {
        
        self.openSeaService = openSeaService
    }
    
    func add(wallet: String?, current: String) {
        
        if let wallet = wallet?.trimmingCharacters(in: .whitespacesAndNewlines), !wallet.isEmpty {
            if wallet != current {
                
                withAnimation(.easeOut(duration: 0.25)) {
                    isLoading = true
                }
                
                openSeaService.getAssets(wallet, nil) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(_):
                            
                            self?.approvedWallet = wallet
                            UserDefaults.standard.set(wallet, forKey: "mywallet")

                        case .failure(let error):
                            
                            self?.error.message = error.rawValue
                        }
                        
                        withAnimation(.easeOut(duration: 0.25)) {
                            self?.isLoading = false
                        }
                    }
                }
            } else {
                
                error.message = "You have already added this wallet."
            }
        }
    }
}

