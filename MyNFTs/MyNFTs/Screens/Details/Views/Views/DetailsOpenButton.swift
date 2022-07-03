//
//  DetailsOpenButton.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct DetailsOpenButton: View {
    var permalink: String
    
    var body: some View {
        HStack {
            Link(destination: URL(string: permalink)!) {
                
                Text("View in OpenSea")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                    .padding(14.0)
                    .background(Color("AccentColor"))
                    .cornerRadius(26)
            }
            .buttonStyle(ScaleListSelectionStyle())
        }
        .padding()
    }
}

//struct DetailsOpenButton_Previews: PreviewProvider {
//    static var previews: some View {
//        let permalink = PreviewData().assets[0].nfts[0].nftPermalink
//        DetailsOpenButton(permalink: permalink)
//    }
//}
