//
//  AssetsList.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 25.06.22.
//

import SwiftUI

struct AssetsList: View {
    @EnvironmentObject var viewModel: AssetsViewModel

    var body: some View {
//        AssetRow()
        
        ScrollView {
            LazyVStack(spacing: 16.0) {
                Button(action: {}) { AssetHeader() }
                    .buttonStyle(ScaleListSelectionStyle())


                ForEach(viewModel.sortedAssets) { currentAsset in
                    NavigationLink {
                        DetailsView(asset: currentAsset)

                    } label: {
                        
                        AssetRow(asset: currentAsset, isFloorValues: viewModel.headerValues.isFloorValues)
                    }
                }                    .buttonStyle(ScaleListSelectionStyle())

            }
            .onReceive(viewModel.$wallet) { _ in viewModel.startSync() }
            
        }
       
    }
}

//struct AssetsList_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetsList()
//            .environmentObject({ () -> AssetsViewModel in
//                let viewModel = AssetsViewModel()
//                viewModel.assets = PreviewData().assets
//                return viewModel
//            }())
//    }
//}
