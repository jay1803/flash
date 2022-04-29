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
                .onChange(of: self.inputText, perform: { value in
                    withAnimation(.easeInOut(duration: 0.1), {
                        if lineNumberOf(text: value) > 0 {
                            height = CGFloat(40 + 25 * lineNumberOf(text: value))
                        }
                    })
                })
                
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
        .frame(height: height)
    }
    
    func lineNumberOf(text: String) -> Int {
        let tok = text.components(separatedBy: "\n")
        return tok.count - 1
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditor()
            .environmentObject(NoteListViewModel())
    }
}
