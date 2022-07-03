//
//  DetailsView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct DetailsView: View {
    @State private var currentIndex = 0
    var asset: Asset
    
    var body: some View {
        VStack(spacing: 0.0) {
            
            DetailsNavigationView(nft: asset.nfts[currentIndex])
            
            ZStack(alignment: .bottom) {
                
                DetailsList(currentIndex: $currentIndex, asset: asset)
            }
        }
        .navigationBarHidden(true)
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(asset: PreviewData().assets[0])
//    }
//}
