//
//  NoteEditor.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct EntryEditor: View {
    
    @Environment(\.colorScheme) var appearance
    @StateObject var viewModel = EditorViewModel()
    @State var parentEntry: Entry? = nil
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            if !viewModel.images.isEmpty {
                ImagePreviewList(viewModel: viewModel)
            }
            HStack(alignment: .bottom, spacing: 8) {
                #if !os(macOS)
                PickImageButton(viewModel: viewModel)
                #endif
                TextInput(viewModel: viewModel)
                SendButton(viewModel: viewModel, entryListViewModel: EntryListViewModel(), parentEntry: $parentEntry)
            }
            .frame(height: viewModel.height)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .sheet(isPresented: $viewModel.showImagePicker, content: {
                PhotoPicker(selectionLimit: 10,
                            pickerResults: $viewModel.images,
                            isPresented: $viewModel.showImagePicker)
            })
            .background(appearance == .dark
                        ? Color.black.edgesIgnoringSafeArea(.bottom)
                        : Color(red: 214/255, green: 217/255, blue: 222/255).edgesIgnoringSafeArea(.bottom))
            .onPreferenceChange(entryEditorHeight.self) { viewModel.height = $0 }
            .simultaneousGesture(DragGesture().onChanged({ _ in
                hideKeyboard()
            }))
        }
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
        Group {
            EntryEditor(viewModel: EditorViewModel(content: "This is a sample content This is a sample content\nThis is a sample content\nthis"))
                .preferredColorScheme(.light)
            
            EntryEditor()
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 120))
    }
}
