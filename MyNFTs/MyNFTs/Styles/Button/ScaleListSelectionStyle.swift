//
//  ScaleListSelectionStyle.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct ScaleListSelectionStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        
        let scale = configuration.isPressed ? 0.97 : 1.0
        
        configuration.label
            .scaleEffect(scale)
            .animation(.easeOut(duration: 0.4), value: scale)
    }
}
