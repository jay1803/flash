//
//  UpdateEditor.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/19.
//

import SwiftUI
import RealmSwift

struct UpdateEditor: View {
    @Binding var inputText: String
    
    var body: some View {
        TextEditor(text: $inputText)
            .padding()
    }
}

struct UpdateEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UpdateEditor(inputText: .constant("This is a sample input text."))
        }
    }
}
