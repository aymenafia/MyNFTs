//
//  DetailsGroup.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI
import NukeUI

struct DetailsGroup: View {
    @State private var detailsTextViewHeight: CGFloat = .zero
    var asset: Asset
    
    var body: some View {
        
        Group {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    
                    LazyImage(source: asset.collectionImageUrl) { state in
                        if let image = state.image {
                            image.resizingMode(.aspectFill)
                        }
                    }
                    .animation(nil)
                    .frame(width: 30, height: 30)
                    .background(Color("MainColor"))
                    .clipShape(Circle())
                    
                    Text(asset.collectionName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(Color("SubtitleTextColor"))
                    
                    Spacer()
                }
                
                DetailsTextView(height: $detailsTextViewHeight, text: .constant(asset.collectionDescription))
                    .frame(height: detailsTextViewHeight)
            }
            .padding()
            .background(Color("SecondaryColor"))
            .cornerRadius(26)
        }
        .padding(EdgeInsets(top: 30, leading: 16, bottom: 90, trailing: 16))
    }
}

//struct DetailsGroup_Previews: PreviewProvider {
//    static var previews: some View {
////        DetailsGroup(asset: PreviewData().assets[3])
//    }
//}
