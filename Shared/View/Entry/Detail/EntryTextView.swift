//
//  EntryMarkdown.swift
//  flash
//
//  Created by Max Zhang on 2022/6/10.
//
import SwiftUI

struct EntryTextView: UIViewRepresentable {
    
    @Binding var content: String
    @Binding var calculatedHeight: CGFloat
    @Binding var selectedContent: String?
    @Binding var isPresentingQuoteView: Bool
    
    func makeUIView(context: UIViewRepresentableContext<EntryTextView>) -> TextView {
        let textView = TextView(content: self.$content,
                                calculatedHeight: self.$calculatedHeight,
                                selectedContent: self.$selectedContent,
                                isPresentingQuoteView: self.$isPresentingQuoteView)
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
        if uiView.text != self.content {
            uiView.text = self.content
        }
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
        EntryTextView.recalculateHeight(view: uiView, result: $calculatedHeight)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $content, height: $calculatedHeight)
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

class TextView: UITextView, UITextViewDelegate {
    @Binding var content: String
    @Binding var calculatedHeight: CGFloat
    @Binding var selectedContent: String?
    @Binding var isPresentingQuoteView: Bool
    
    init(content: Binding<String>,
         calculatedHeight: Binding<CGFloat>,
         selectedContent: Binding<String?>,
         isPresentingQuoteView: Binding<Bool>) {
        self._content               = content
        self._calculatedHeight      = calculatedHeight
        self._selectedContent       = selectedContent
        self._isPresentingQuoteView = isPresentingQuoteView
        super.init(frame: .zero, textContainer: nil)
        
        let quoteMenu = UIMenuItem(title: "Quote", action: #selector(quote))
        UIMenuController.shared.menuItems = [quoteMenu]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func quote() {
        guard let selectedText = self.text(in: selectedTextRange!) else { return }
        self.selectedContent = selectedText
        self.isPresentingQuoteView = true
    }
}
