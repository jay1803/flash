//
//  UpdateEditor.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/19.
//

import SwiftUI
import RealmSwift

struct UpdateEditor: View {
    var quoteContent: String?
    @Binding var noteContent: String
    @FocusState private var focusedField: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if let quoteContent = quoteContent {
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
            }
            
            TextEditor(text: $noteContent)
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

struct UpdateEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UpdateEditor(noteContent: .constant("This is sample note content"))
        }
    }
}
