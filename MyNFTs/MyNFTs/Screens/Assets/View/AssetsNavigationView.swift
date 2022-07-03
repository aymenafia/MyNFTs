//
//  AssetsNavigationView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct AssetsNavigationView: View {
    @EnvironmentObject var viewModel: AssetsViewModel
    @State private var showingAlert = false
    @State private var showingWallets = false
    
    var body: some View {
        HStack {
            
            Text("My Portfolio")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(1)

            Spacer()
            
          
            Button {
                
                if (!viewModel.isSyncActive) {
                    
                    showingWallets = true
                } else {
                    
                    viewModel.error.message = "You can't access your wallet settings during synchronization."
                }
            } label: {
                
                Image("WalletIcon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("AccentColor"))
            }
            .padding(7.0)
            .frame(width: 35.0, height: 35.0)
            .background(Color("SecondaryColor"))
            .clipShape(Circle())
            .sheet(isPresented: $showingWallets) {
                AddWalletView(currentWallet: $viewModel.wallet)
                    .interactiveDismissDisabled(true)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct AssetsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsNavigationView()
            .previewLayout(.fixed(width: 350, height: 60))
    }
}
