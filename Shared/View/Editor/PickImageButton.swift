//
//  PickImageButton.swift
//  flash
//
//  Created by Max Zhang on 2022/5/9.
//

import SwiftUI

struct PickImageButton: View {
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        Button(action: {
            viewModel.showImagePicker.toggle()
        }) {
            IconButton(systemName: "plus.circle.fill",
                       height: viewModel.initHeight,
                       foregroundColor: Color.gray)
        }
    }
}

struct PickImageButton_Previews: PreviewProvider {
    static var previews: some View {
        PickImageButton(viewModel: EditorViewModel())
            .environmentObject(EditorViewModel())
    }
}
