//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct EntryEditorView: View {
    private let initHeight: CGFloat = 38
    
    @State private var inputText: String = ""
    @State private var height: CGFloat = CGFloat()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(inputText.isEmpty ? " " : inputText)
                .frame(width: UIScreen.main.bounds.width - 78, alignment: .leading)
                .lineLimit(10)
                .padding(.leading, 15)
                .padding(.trailing, 42)
                .padding(.vertical, 8)
                .foregroundColor(.clear)
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(initHeight / 2)
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: textViewHeight.self,
                                    value: geometry.frame(in: .local).size.height)
                })
            
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $inputText)
                    .frame(height: height)
                    .frame(minHeight: initHeight)
                    .padding(.leading, 10)
                    .padding(.trailing, 36)
                    .background(Color.white)
                    .cornerRadius(initHeight / 2)
                    
                Button(action: {
                    let content = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
                    if content.isEmpty {
                        showingAlert.toggle()
                    } else {
                        Entry(content: content).add()
                        
                    }
                    inputText = ""
                    height = initHeight
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: initHeight - CGFloat(4), height: initHeight - CGFloat(4))
                        .padding(.trailing, 2)
                        .padding(.bottom, 2)
                        .foregroundColor(.green)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Content cannot be empty"), message: Text("Try to add some text to the content"), dismissButton: .default(Text("OK")))
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: initHeight / 2)
            .stroke(Color(red: 196/255, green: 196/255, blue: 198/255), lineWidth: 1))
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .frame(height: height + CGFloat(10))
        .background(Color(red: 214/255, green: 217/255, blue: 222/255).edgesIgnoringSafeArea(.bottom))
        .onPreferenceChange(textViewHeight.self) { height = $0 }
            .simultaneousGesture(DragGesture().onChanged({ _ in
                hideKeyboard()
            }))
    }
}

struct textViewHeight: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value + nextValue()
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        EntryEditorView()
    }
}
