//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct EntryEditorView: View {
    @ObservedRealmObject var entryList: EntryList
    
    private let initHeight: CGFloat = 38
    
    @State private var inputText: String = ""
    @State private var height: CGFloat = CGFloat()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Text(inputText.isEmpty ? " " : inputText)
                .lineLimit(10)
                .padding(.leading, 15)
                .padding(.trailing, 42)
                .foregroundColor(.clear)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
                .fixedSize(horizontal: false, vertical: true)

            ZStack(alignment: .bottomTrailing) {
                
                TextEditor(text: $inputText)
                    .frame(height: height)
                    .frame(minHeight: initHeight)
                    .padding(.leading, 10)
                    .padding(.trailing, 36)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(initHeight / 2)
                    
                Button(action: {
                    let content = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
                    if content.isEmpty {
                        showingAlert.toggle()
                    } else {
                        let entry = Entry(content: content)
                        $entryList.items.append(entry)
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
        .frame(minHeight: initHeight + CGFloat(10))
        .background(Color(red: 214/255, green: 217/255, blue: 222/255).edgesIgnoringSafeArea(.bottom))
        .onPreferenceChange(ViewHeightKey.self) { height = $0 }
        .simultaneousGesture(DragGesture().onChanged({ _ in
            hideKeyboard()
        }))
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 18 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        EntryEditorView(entryList: EntryList())
    }
}
