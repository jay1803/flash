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
        VStack {
            Text(quoteContent)
            TextEditor(text: $entryContent)
                .padding()
        }
    }
}

struct QuoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        QuoteEditor(quoteContent: "This is a quote", entryContent: .constant("This is a entry content"))
    }
}
