//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct NoteEditor: View {
    @ObservedResults(Note.self, sortDescriptor: SortDescriptor.init(keyPath: "createdAt", ascending: false)) var notesFetched
    
    private let initHeight: CGFloat = 36
    
    @State private var inputText: String = ""
    @State private var height: CGFloat = 36
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TextEditor(text: $inputText)
                .frame(height: height)
                .lineSpacing(5)
                .keyboardType(.default)
                .padding(.horizontal, 10)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .onChange(of: self.inputText, perform: { value in
                    withAnimation(.easeInOut(duration: 0.1), {
                        if lineNumberOf(text: value) > 0 {
                            height = initHeight + CGFloat(25 * lineNumberOf(text: value))
                        }
                    })
                })
                
                
            Button(action: {
                let note = Note(content: inputText)
                $notesFetched.append(note)
//                viewModel.create(content: inputText)
                inputText = ""
                height = initHeight
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 2)
                    .padding(.bottom, 2)
                    .foregroundColor(.green)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
            .stroke(Color(red: 196/255, green: 196/255, blue: 198/255), lineWidth: 1))
        .padding()
        .frame(height: height + CGFloat(10))
        .background(Color(red: 214/255, green: 217/255, blue: 222/255).edgesIgnoringSafeArea(.bottom))

    }
    
    func lineNumberOf(text: String) -> Int {
        let tok = text.components(separatedBy: "\n")
        return tok.count - 1
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditor()
            .environmentObject(NoteListViewModel())
    }
}
