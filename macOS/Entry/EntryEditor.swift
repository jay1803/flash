//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

extension NSTextView {
  open override var frame: CGRect {
    didSet {
      backgroundColor = .clear
      drawsBackground = true
    }
  }
}

struct EntryEditor: View {
    @EnvironmentObject var realmManager: RealmManager
    let entry: Entry?
    private let initHeight: CGFloat = 38
    
    @State private var inputText: String = ""
    @State private var height: CGFloat = CGFloat()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(inputText.isEmpty ? " " : inputText)
                .frame(width: .infinity, alignment: .leading)
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
            
            HStack(alignment: .bottom) {
                TextEditor(text: $inputText)
                    .frame(height: height)
                    .frame(minHeight: initHeight)
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
                    .cornerRadius(19)
                    .overlay(RoundedRectangle(cornerRadius: initHeight / 2)
                        .stroke(Color(red: 1, green: 1, blue: 1, opacity: 0.2), lineWidth: 1))
                
                Button(action: {
                    let content = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
                    if content.isEmpty {
                        showingAlert.toggle()
                    } else {
                        if let entry = entry {
                            realmManager.replyTo(entry: entry, with: Entry(content: content))
                        } else {
                            realmManager.add(entry: Entry(content: content))
                        }
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
                .buttonStyle(.plain)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Content cannot be empty"), message: Text("Try to add some text to the content"), dismissButton: .default(Text("OK")))
                }
            }
        }
        .padding(8)
        .frame(height: height + CGFloat(16))
        .onPreferenceChange(textViewHeight.self) { height = $0 }
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
        EntryEditor(entry: nil)
            .environmentObject(RealmManager(name: "flash"))
            .frame(height: 50)
    }
}

