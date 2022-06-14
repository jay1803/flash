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
    
    @Environment(\.colorScheme) var appearance
    @EnvironmentObject var realmManager: RealmManager
    let entry: Entry?
    private let initHeight: CGFloat = 38
    
    @State private var inputText: String = ""
    @State private var height: CGFloat = CGFloat()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(inputText.isEmpty ? " " : inputText)
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
                    .background(appearance == .dark
                                ? Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                : Color.clear)
                    .cornerRadius(19)
                    .overlay(
                        RoundedRectangle(cornerRadius: initHeight / 2)
                            .stroke(appearance == .dark
                                    ? Color(red: 1, green: 1, blue: 1, opacity: 0.2)
                                    : Color(red: 196/255, green: 196/255, blue: 198/255), lineWidth: 1))
                
                SendButton()
            }
        }
        .padding(8)
        .frame(height: height + CGFloat(16))
        .onPreferenceChange(textViewHeight.self) { height = $0 }
    }
}

struct entryEditorHeight: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value + nextValue()
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            EntryEditor(entry: nil)
                .environmentObject(RealmManager(name: "flash"))
                .preferredColorScheme($0)
        }
        .previewLayout(.fixed(width: 420, height: 56))
    }
}

