//
//  AddWalletScrollView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct AddWalletScrollView: View {
    @Binding var newWallet: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                
                Text("My wallet.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text("Enter the wallet address related to\nyour OpenSea account.")
                    .font(.subheadline)
                    .foregroundColor(Color("SubtitleTextColor"))
                
                Spacer(minLength: 16)
                
                TextField("0xab1b584fc90d73B529av4346jk830ee3D2061681", text: $newWallet)
                    .padding(.horizontal, 12.0)
                    .frame(height: 50.0)
                    .background(Color("TextFieldColor"))
                    .cornerRadius(26)
            }
            .padding(EdgeInsets(top: 8, leading: 22, bottom: 100, trailing: 22))
        }
        .onAppear {
            
            UIScrollView.appearance().keyboardDismissMode = .onDrag
        }
    }
}

struct AddWalletScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AddWalletScrollView(newWallet: .constant(""))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
