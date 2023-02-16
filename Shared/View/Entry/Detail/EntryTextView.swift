//
//  EntryMarkdown.swift
//  flash
//
//  Created by Max Zhang on 2022/6/10.
//
import SwiftUI

struct EntryTextView: UIViewRepresentable {
    @ObservedObject var viewModel: EntryDetailViewModel
    @Binding var content: String
    @Binding var calculatedHeight: CGFloat
    @Binding var selectedContent: String?
    @Binding var isPresentingQuoteView: Bool
    @Binding var annotations: [NSRange?]
    @Binding var highlightedRange: NSRange?
    
    var fontSize: CGFloat
    
    func makeUIView(context: UIViewRepresentableContext<EntryTextView>) -> TextView {
        let textView = TextView(viewModel: viewModel,
                                content: self.$content,
                                calculatedHeight: self.$calculatedHeight,
                                selectedContent: self.$selectedContent,
                                isPresentingQuoteView: self.$isPresentingQuoteView,
                                annotations: self.$annotations,
                                highlightedRange: self.$highlightedRange,
                                fontSize: fontSize)
        
        let attributedStyle: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        
        textView.delegate                   = context.coordinator
        textView.isSelectable               = true
        textView.isUserInteractionEnabled   = true
        textView.isEditable                 = false
        textView.isScrollEnabled            = false
        textView.backgroundColor            = UIColor.clear
        textView.attributedText             = NSMutableAttributedString(string: content, attributes: attributedStyle)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<EntryTextView>) {
        let attributedStyle: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let attributedContent = NSMutableAttributedString(string: content, attributes: attributedStyle)
        
        if uiView.text != self.content {
            let attributedText = NSAttributedString(string: self.content)
            uiView.attributedText = attributedText
        }
        self.viewModel.entry?.highlightedRanges.forEach { annotation in
            let highlightStyles: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
            attributedContent.setAttributes(highlightStyles, range: NSRange(location: annotation.location, length: annotation.length))
        }
        uiView.attributedText = attributedContent
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
    var viewModel: EntryDetailViewModel
    @Binding var content: String
    @Binding var calculatedHeight: CGFloat
    @Binding var selectedContent: String?
    @Binding var isPresentingQuoteView: Bool
    @Binding var annotations: [NSRange?]
    @Binding var highlightedRange: NSRange?
    var fontSize: CGFloat
    
    init(viewModel: EntryDetailViewModel,
         content: Binding<String>,
         calculatedHeight: Binding<CGFloat>,
         selectedContent: Binding<String?>,
         isPresentingQuoteView: Binding<Bool>,
         annotations: Binding<[NSRange?]>,
         highlightedRange: Binding<NSRange?>,
         fontSize: CGFloat) {
        self.viewModel              = viewModel
        self._content               = content
        self._calculatedHeight      = calculatedHeight
        self._selectedContent       = selectedContent
        self._isPresentingQuoteView = isPresentingQuoteView
        self._annotations           = annotations
        self._highlightedRange      = highlightedRange
        self.fontSize               = fontSize
        
        super.init(frame: .zero, textContainer: nil)
        
        let attributedStyle: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let attributedContent = NSMutableAttributedString(string: self.content, attributes: attributedStyle)
        self.viewModel.entry?.highlightedRanges.forEach { annotation in
            let highlightStyles: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
            attributedContent.setAttributes(highlightStyles, range: NSRange(location: annotation.location, length: annotation.length))
        }
        self.attributedText = attributedContent
        
        let quoteMenu = UIMenuItem(title: "Quote", action: #selector(quote))
        let highlightMenu = UIMenuItem(title: "Highlight", action: #selector(highlight))
        UIMenuController.shared.menuItems = [quoteMenu, highlightMenu]
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
    
    @objc
    func highlight() {
        guard let selectedText = self.text(in: selectedTextRange!) else { return }
        self.selectedContent = selectedText
        
        if let range = self.selectedTextRange {
            let attributedStyle: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
            let attributedContent = NSMutableAttributedString(string: content, attributes: attributedStyle)
            let highlightRange = NSRange(location: self.offset(from: self.beginningOfDocument, to: range.start), length: self.offset(from: range.start, to: range.end))
            
            self.annotations.append(highlightRange)
            self.viewModel.highlight(range: highlightRange)
            self.annotations.forEach { annotation in
                let highlightStyles: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
                attributedContent.setAttributes(highlightStyles, range: annotation!)
            }
            self.attributedText = attributedContent
        }
        print(self.annotations)
    }
}
