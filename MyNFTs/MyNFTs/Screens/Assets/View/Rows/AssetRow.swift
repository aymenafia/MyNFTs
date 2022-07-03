//
//  AssetRow.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 25.06.22.
//

import SwiftUI
import NukeUI

struct AssetRow: View {
    
    var asset: Asset
    var isFloorValues: Bool

    var body: some View {
        HStack(spacing: 12.0) {
            LazyImage(source: asset.collectionImageUrl) { state in
                if let image = state.image {
                    image.resizingMode(.aspectFill)
                }
            }
            .animation(nil)
            .frame(width: 65, height: 65)
            .background(Color("MainColor"))
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 6.0) {
                
                Text(asset.collectionName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                HStack(spacing: 12.0) {
                    HStack {
                        
                        Image("CardsIcon")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17)
                            .foregroundColor(Color("InvertMainColor"))
                        
                        Text("\(asset.nfts.count)")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        HStack {
                            Text("Ξ \(isFloorValues ? String(asset.floorPrice) : String(asset.averagePrice))")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        .padding(EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 8))
                        .background(Color("MainColor"))
                        .cornerRadius(12)

                    }
                }
            }
            Spacer()
            
            Image("ArrowRight")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 18.0, height: 18.0)
                .foregroundColor(Color("InvertMainColor"))
        }
        .padding(12.0)
        .background(Color("SecondaryColor"))
        .cornerRadius(26)
    }
}

//struct AssetRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetRow(asset: PreviewData().assets[0], isFloorValues: true)
//            .previewLayout(.fixed(width: 350, height: 130))
//    }
//}
