//
//  CustomPagerView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct CustomPagerView: View {
    
    @State private var opacity = 1.0
    @State private var hideCallInQueue = 0
    
    let numberOfPages: Int
    let currentIndex: Int
    
    var body: some View {
        HStack {
            
            Text("\(currentIndex+1) / \(numberOfPages)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                .onChange(of: currentIndex) { _ in
                    
                    opacity = 1
                    hidePagerAfter(seconds: 2)
                }
        }
        .frame(minWidth: 55)
        .background(Color.black.opacity(0.8))
        .cornerRadius(12)
        .opacity(opacity)
        .animation(.linear, value: opacity)
        .onAppear {
            
            hidePagerAfter(seconds: 2)
        }
    }
    
    private func hidePagerAfter(seconds: Int) {
        hideCallInQueue += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
            
            hideCallInQueue -= 1
            if hideCallInQueue == 0 {
                opacity = 0
            }
        }
    }
}

struct CustomPagerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPagerView(numberOfPages: 3, currentIndex: 0)
            .previewLayout(.fixed(width: 350, height: 180))
    }
}

