//
//  ErrorInfo.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import Foundation

struct ErrorInfo: Identifiable {
    
    let id = UUID()
    var message = "" {
        didSet {
            isPresented = true
        }
    }
    var isPresented = false
}
