//
//  CoinbaseServiceModel.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

struct CoinbaseData: Decodable {
    let data: CoinbaseDataAmount
}

struct CoinbaseDataAmount: Decodable {
    let amount : String?
}
