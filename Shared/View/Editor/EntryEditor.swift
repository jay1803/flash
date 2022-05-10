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
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var viewModel: EditorViewModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            PickImageButton()
            TextInput()
            SendButton()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
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
            EntryEditor()
                .environmentObject(RealmManager(name: "flash"))
                .environmentObject(EditorViewModel())
                .preferredColorScheme(.light)
            
            EntryEditor()
                .environmentObject(RealmManager(name: "flash"))
                .environmentObject(EditorViewModel())
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 44))
    }
}
