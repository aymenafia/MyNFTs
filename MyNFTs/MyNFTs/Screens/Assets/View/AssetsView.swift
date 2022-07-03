//
//  AssetsView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 25.06.22.
//

import SwiftUI

struct AssetsView: View {
    @StateObject var viewModel = AssetsViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                AssetsNavigationView()
                AssetsList()
            }
            .navigationBarHidden(true)
          
        }
        .environmentObject(viewModel)
    }
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView()
    }
}
