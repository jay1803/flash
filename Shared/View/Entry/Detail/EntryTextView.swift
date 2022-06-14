//
//  EntryMarkdown.swift
//  flash
//
//  Created by Max Zhang on 2022/6/10.
//
import SwiftUI

struct EntryTextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    
    typealias UIViewType = UITextView
    
    func makeUIView(context: UIViewRepresentableContext<EntryTextView>) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.clear
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<EntryTextView>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
        EntryTextView.recalculateHeight(view: uiView, result: $calculatedHeight)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        
        init(text: Binding<String>, height: Binding<CGFloat>) {
            self.text = text
            self.calculatedHeight = height
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
            EntryTextView.recalculateHeight(view: textView, result: calculatedHeight)
        }
    }
    
    private static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height
            }
        }
    }
}
