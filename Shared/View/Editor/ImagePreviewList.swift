//
//  ImagePreviewList.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/18.
//

import SwiftUI

struct ImagePreviewList: View {
    @Environment(\.colorScheme) var appearance
    @ObservedObject var viewModel: EditorViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.images, id: \.self) { image in
                    ImagePreview(viewModel: viewModel, image: image)
                }
            }
        }
        .padding()
        .background(appearance == .dark
                    ? Color.black.edgesIgnoringSafeArea(.bottom)
                    : Color(red: 214/255, green: 217/255, blue: 222/255).edgesIgnoringSafeArea(.bottom))
    }
}

struct ImagePreviewList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImagePreviewList(viewModel: EditorViewModel())
                .preferredColorScheme(.light)
            ImagePreviewList(viewModel: EditorViewModel())
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
