//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

extension UITextView {
  open override var frame: CGRect {
    didSet {
      backgroundColor = .clear
    }
  }
}

struct EntryEditor: View {
    @Environment(\.colorScheme) var appearance
    @EnvironmentObject var realmManager: RealmManager
    @ObservedObject var viewModel: EditorViewModel
    
    private let initHeight: CGFloat = 38
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(viewModel.content.isEmpty ? " " : viewModel.content)
                .frame(width: UIScreen.main.bounds.width - 78, alignment: .leading)
                .lineLimit(10)
                .padding(.leading, 15)
                .padding(.trailing, 42)
                .padding(.vertical, 10)
                .foregroundColor(.clear)
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(initHeight / 2)
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: textViewHeight.self,
                                    value: geometry.frame(in: .local).size.height)
                })
            
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $viewModel.content)
                    .frame(height: viewModel.height)
                    .frame(minHeight: initHeight)
                    .padding(.leading, 10)
                    .padding(.trailing, 36)
                    .background(appearance == .dark
                                ? Color.clear
                                : Color.white)
                    .cornerRadius(initHeight / 2)
                    
                SendButton(viewModel: viewModel,
                           initHeight: initHeight)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: initHeight / 2)
                .stroke(appearance == .dark
                        ? Color(red: 1, green: 1, blue: 1, opacity: 0.38)
                        : Color(red: 196/255, green: 196/255, blue: 198/255), lineWidth: 1))
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .frame(height: viewModel.height + CGFloat(10))
        .background(appearance == .dark
                    ? Color.clear.edgesIgnoringSafeArea(.bottom)
                    : Color(red: 214/255, green: 217/255, blue: 222/255).edgesIgnoringSafeArea(.bottom))
        .onPreferenceChange(textViewHeight.self) { viewModel.height = $0 }
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
        Group {
            EntryEditor(viewModel: EditorViewModel())
                .environmentObject(RealmManager(name: "flash"))
                .preferredColorScheme(.light)
            
            EntryEditor(viewModel: EditorViewModel())
                .environmentObject(RealmManager(name: "flash"))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 420, height: 44))
    }
}
