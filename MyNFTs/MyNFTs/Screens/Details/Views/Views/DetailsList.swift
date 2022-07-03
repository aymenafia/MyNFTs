//
//  DetailsList.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct DetailsList: View {
    @Binding var currentIndex: Int
    var asset: Asset
    
    var body: some View {
        ScrollView {
            
            DetailsPager(currentIndex: $currentIndex, asset: asset)
            DetailsGroup(asset: asset)
        }
    }
}

//struct DetailsList_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsList(currentIndex: .constant(0), asset: PreviewData().assets[3])
//    }
//}
