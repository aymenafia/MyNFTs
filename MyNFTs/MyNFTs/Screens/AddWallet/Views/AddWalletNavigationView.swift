//
//  AddWalletNavigationView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct AddWalletNavigationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            
            Button {
                
                dismiss()
            } label: {
                
                Image("ArrowBottom")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("AccentColor"))
            }
            .padding(7.0)
            .frame(width: 35.0, height: 35.0)
            .background(Color("SecondaryColor"))
            .clipShape(Circle())
            
            Spacer()
        }
        .padding(EdgeInsets(top: 22, leading: 16, bottom: 8, trailing: 16))
    }
}

struct AddWalletNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AddWalletNavigationView()
            .previewLayout(.fixed(width: 350, height: 60))
    }
}
