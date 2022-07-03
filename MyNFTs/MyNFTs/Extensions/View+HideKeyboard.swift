//
//  View+HideKeyboard.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

