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
    @FocusState private var focusedField: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(quoteContent)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1))
                }
            }.padding()
            
            Divider()
            
            TextEditor(text: $entryContent)
                .padding(.horizontal, 12)
                .focused($focusedField)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.focusedField = true
            }
        })
    }
}

struct QuoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        QuoteEditor(quoteContent: "This is a quote. This is a quote. This is a quote. This is a quote",
                    entryContent: .constant("This is a reply, This is a reply, This is a reply. This is a reply"))
    }
}
