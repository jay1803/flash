//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI

struct NoteEditor: View {
    @EnvironmentObject var viewModel: NoteListViewModel
    
    @State private var inputText: String = ""
    @State private var height: CGFloat = 40
    
    var body: some View {
        HStack {
            TextEditor(text: $inputText)
                .frame(height: height)
                .lineSpacing(5)
                .keyboardType(.default)
                .padding(.horizontal, 10)
                
            Button(action: {
                viewModel.create(content: inputText)
                inputText = ""
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.trailing, 2)
                    .foregroundColor(.green)
            }
        }
        .overlay(
        RoundedRectangle(cornerRadius: 20)
            .stroke(.gray, lineWidth: 1))
        .padding()
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditor()
            .environmentObject(NoteListViewModel())
    }
}
