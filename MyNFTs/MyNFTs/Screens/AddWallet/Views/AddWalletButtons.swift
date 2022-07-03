//
//  AddWalletButtons.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct AddWalletButtons: View {
    var viewModel: AddWalletViewModel
    var currentWallet: String
    @Binding var newWallet: String
    
    var body: some View {
        HStack(spacing: 16.0) {
            
            Button {
                
                if let pasteString = UIPasteboard.general.string {
                    
                    newWallet = pasteString
                    viewModel.add(wallet: newWallet, current: currentWallet)
                    hideKeyboard()
                }
            } label: {
                
                Text("Paste from clipboard")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color("SubtitleTextColor"))
                    .lineLimit(1)
            }
            .disabled(viewModel.isLoading)
            .buttonStyle(ScaleListSelectionStyle())
            
            Button {
                
                viewModel.add(wallet: newWallet, current: currentWallet)
                hideKeyboard()
            } label: {
                
                Text("Continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                    .padding(14.0)
                    .background(Color("AccentColor"))
                    .cornerRadius(26)
            }
            .disabled(viewModel.isLoading)
            .buttonStyle(ScaleListSelectionStyle())
        }
        .padding(.bottom, 16)
    }
}

struct AddWalletButtons_Previews: PreviewProvider {
    static var previews: some View {
        AddWalletButtons(viewModel: AddWalletViewModel(), currentWallet: "0x1b584fc86390d7D83B529a4346330ee3D2061681", newWallet: .constant("0x1b584fc86390d7D83B529a4346330ee3D2061681"))
    }
}
