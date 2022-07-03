//
//  AddWalletView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct AddWalletView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var currentWallet: String //from AssetsViewModel.swift
    @State private var newWallet: String = ""
    
    @ObservedObject var viewModel = AddWalletViewModel()
    
    var body: some View {
        VStack(spacing: 0.0) {
            
            AddWalletNavigationView()
            
            ZStack(alignment: .bottom) {
                
                AddWalletScrollView(newWallet: $newWallet)
                AddWalletButtons(viewModel: viewModel, currentWallet: currentWallet, newWallet: $newWallet)
            }
        }
        .overlay {
            if viewModel.isLoading {
                LoadingIndicator(animation: .circleRunner, color: .white, size: .small, speed: .fast)
                    .padding(20)
                    .background(.black.opacity(0.95))
                    .cornerRadius(18)
                    .transition(.opacity)
            }
        }
        .onReceive(viewModel.$approvedWallet) { approvedWallet in
            if let approvedWallet = approvedWallet {
                currentWallet = approvedWallet
                dismiss()
            }
        }
        .popup(isPresented: $viewModel.error.isPresented, type: .floater(verticalPadding: 0, useSafeAreaInset: true), position: .top, autohideIn: 3) {
            
            ErrorView(error: viewModel.error)
        }
    }
}

struct AddWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddWalletView(currentWallet: .constant("0x1b584fc86390d7D83B529a4346330ee3D2061681"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        }
    }
}
