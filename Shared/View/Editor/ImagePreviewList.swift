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
                ForEach(viewModel.attachments) { attachment in
                    Image(uiImage: attachment.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        
                }
            }
        }
        .padding()
        .background(appearance == .dark
                    ? Color.clear.edgesIgnoringSafeArea(.bottom)
                    : Color(red: 214/255, green: 217/255, blue: 222/255).edgesIgnoringSafeArea(.bottom))
    }
}

struct ImagePreviewList_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreviewList(viewModel: EditorViewModel())
    }
}
