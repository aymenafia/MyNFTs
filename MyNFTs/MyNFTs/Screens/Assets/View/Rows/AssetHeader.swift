//
//  AssetHeader.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct AssetHeader: View {
    @EnvironmentObject var viewModel: AssetsViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: 12.0) {
                    
                let isFloorValues = viewModel.headerValues.isFloorValues
                    
                VStack(alignment: .leading) {
                        
                    Text(isFloorValues ? "TOTAL FLOOR VALUE" :  "TOTAL AVERAGE VALUE")
                        .font(.custom("Helvetica Neue Condensed Bold", size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color("SubtitleHeaderColor"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        
                    Text("Ξ \(isFloorValues ? viewModel.headerValues.floor.eth : viewModel.headerValues.average.eth)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        
                    Text(isFloorValues ? viewModel.headerValues.floor.fiat : viewModel.headerValues.average.fiat)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color("SubtitleHeaderColor"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                .onTapGesture {
                    viewModel.headerValues.isFloorValues.toggle()
                }
                
                Spacer()
                
                Group {
                    if viewModel.isSyncActive {
                        
                        LoadingIndicator(animation: .pulse, color: .white)
                    } else {
                        
                        Button {
                            
                            viewModel.startSync()
                        } label: {
                            
                            Image("SyncIcon")
                                .resizable()
                                .scaledToFit()
                                .padding(7.0)
                        }
                    }
                }
                .frame(width: 40.0, height: 40.0)
                .background(Color("SyncBackgroundColor"))
                .clipShape(Circle())
            }
            .padding(EdgeInsets(top: 40, leading: 26, bottom: 40, trailing: 26))
            .background(
                Image("GradientBackgroundImage").resizable()
            )
            
            if (viewModel.isSyncActive) {
                
                ProgressView(value: viewModel.headerValues.progress, total: 1.0)
                    .padding(.horizontal, 10.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("SyncBackgroundColor")))
            }
        }
        .cornerRadius(26)
    }
}

struct AssetHeader_Previews: PreviewProvider {
    static var previews: some View {
        AssetHeader()
            .previewLayout(.fixed(width: 350, height: 180))
            .environmentObject(AssetsViewModel())
    }
}
