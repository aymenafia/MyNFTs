//
//  DetailsNavigationView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//


import SwiftUI

struct DetailsNavigationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var nft: Asset.NFT
    
    var body: some View {
        HStack(spacing: 6.0) {
            
            Button {
                
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                
                Image("ArrowLeft")
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
            
            Text(nft.nftName)
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(.trailing, 35.0)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

//struct DetailsNavigationViewView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsNavigationView(nft: PreviewData().assets[0].nfts[0])
//            .previewLayout(.fixed(width: 350, height: 60))
//    }
//}
