//
//  OpenSeaError.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 25.06.22.
//

import Foundation

enum OpenSeaError: String, Error {
    case error = "OpenSea is not accessible at the moment. Please try again later or check @apiopensea on Twitter."
    case unknown = "OpenSea doesn't know this wallet. Please verify your wallet address and try again."
}
