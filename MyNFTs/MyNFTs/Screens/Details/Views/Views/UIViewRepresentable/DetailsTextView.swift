//
//  DetailsTextView.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 26.06.22.
//

import SwiftUI

struct DetailsTextView: UIViewRepresentable {
    
    @Binding var height: CGFloat
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView(frame: .zero)
        
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.font = UIFont.preferredFont(forTextStyle: .callout)
        
        textView.backgroundColor = .clear
        textView.textColor = UIColor(Color("SubtitleTextColor"))
        textView.tintColor = UIColor(Color("AccentColor"))
        
        textView.autocapitalizationType = .sentences
        textView.dataDetectorTypes = .link
        
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        DispatchQueue.main.async {
            if textView.text != text { textView.text = text }
            let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude))
            if size.height != height { height = size.height }
        }
    }
}
