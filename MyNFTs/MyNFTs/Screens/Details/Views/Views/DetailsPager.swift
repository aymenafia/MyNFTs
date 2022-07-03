//
//  DetailsPager.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI
import NukeUI

struct DetailsPager: View {
    @Binding var currentIndex: Int
    var asset: Asset
    
    var body: some View {
        TabView(selection: $currentIndex) {
            
            ForEach(Array(asset.nfts.enumerated()), id: \.element) { index, nft in
                
                LazyImage(source: nft.nftImageUrl) { state in
                    if let image = state.image {
                        image.resizingMode(.aspectFit)
                    }
                }
                .animation(nil)
                .background(Color("SecondaryColor"))
                .tag(index)
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
        .background(Color("SecondaryColor"))
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .topTrailing) {
            
            CustomPagerView(numberOfPages: asset.nfts.count, currentIndex: currentIndex)
                .padding()
        }
    }
}

//struct DetailsPager_Previews: PreviewProvider {
//    static var previews: some View {
////        DetailsPager(currentIndex: .constant(0), asset: PreviewData().assets[0])
//    }
//}
