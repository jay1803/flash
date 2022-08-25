//
//  QuoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/8/24.
//

import SwiftUI
import RealmSwift

struct QuoteEditor: View {
    var quoteContent: String
    @Binding var entryContent: String
    @Environment(\.colorScheme) var appearance
    @State var parentEntry: Entry? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(quoteContent)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1))
                }
                Text("Reply to the quote: ")
                    .font(.caption)
            }
            .padding(.horizontal, 16)
            
            Divider()
            
            TextEditor(text: $entryContent)
                .padding(.horizontal, 12)
        }
    }
}

struct QuoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        QuoteEditor(quoteContent: "This is a quote. This is a quote. This is a quote. This is a quote",
                    entryContent: .constant("This is a reply, This is a reply, This is a reply. This is a reply"))
    }
}
