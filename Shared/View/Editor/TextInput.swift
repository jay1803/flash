//
//  TextInput.swift
//  flash
//
//  Created by Max Zhang on 2022/5/9.
//

import SwiftUI

struct TextInput: View {
    
    @Environment(\.colorScheme) var appearance
    @EnvironmentObject var viewModel: EditorViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(viewModel.content.isEmpty ? " " : viewModel.content)
                .frame(width: UIScreen.main.bounds.width - 108, alignment: .leading)
                .lineLimit(10)
                .padding(.vertical, 8)
                .foregroundColor(.clear)
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(viewModel.initHeight / 2)
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: textViewHeight.self,
                                    value: geometry.frame(in: .local).size.height)
                })
            
            TextEditor(text: $viewModel.content)
                .frame(height: viewModel.height)
                .frame(minHeight: viewModel.initHeight)
                .padding(.horizontal, 8)
                .background(appearance == .dark
                            ? Color.clear
                            : Color.white)
                .cornerRadius(viewModel.initHeight / 2)
        }
        .overlay(
            RoundedRectangle(cornerRadius: viewModel.initHeight / 2)
                .stroke(appearance == .dark
                        ? Color(red: 1, green: 1, blue: 1, opacity: 0.38)
                        : Color(red: 196/255, green: 196/255, blue: 198/255), lineWidth: 1))
    }
}

struct TextInput_Previews: PreviewProvider {
    static var previews: some View {
        TextInput()
            .environmentObject(EditorViewModel())
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 44))
    }
}