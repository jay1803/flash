//
//  PickImageButton.swift
//  flash
//
//  Created by Max Zhang on 2022/5/9.
//

import SwiftUI

struct PickImageButton: View {
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var viewModel: EditorViewModel
    
    var body: some View {
        Button(action: {
            viewModel.showImagePicker.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: viewModel.initHeight,
                       height: viewModel.initHeight)
                .background(Color.white)
                .cornerRadius(viewModel.initHeight / 2)
                .foregroundColor(.gray)
        }
    }
}

struct PickImageButton_Previews: PreviewProvider {
    static var previews: some View {
        PickImageButton()
            .environmentObject(EditorViewModel())
    }
}
