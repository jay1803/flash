//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI

struct NoteEditor: View {
    @State private var inputText: String = ""
    var body: some View {
        HStack {
            TextField("Note content...", text: $inputText)
                .frame(height: 50)
                .padding(.leading)
                .padding(.trailing)
                .cornerRadius(10)
                .border(Color(UIColor.separator))
                
            Button(action: {
                print("Send button pressed...")
            }) {
                Label("Send", systemImage: "paperplane.fill")
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditor()
            .scaledToFit()
    }
}
