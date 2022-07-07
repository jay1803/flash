//
//  ImagePreview.swift
//  flash
//
//  Created by Max Zhang on 2022/7/5.
//

import SwiftUI

struct ImagePreview: View {
    @ObservedObject var viewModel: EditorViewModel
    
    var image: UIImage
    var index: Int {
        viewModel.images.firstIndex(where: { $0 == image })!
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            Button(action: {
                viewModel.images.remove(at: index)
            }) {
                Image(systemName: "xmark.circle.fill")
                    .frame(width: 17, height: 17)
                    .foregroundColor(.gray)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 1, x: 0, y: 0)
                    .padding(.trailing, 2)
                    .padding(.top, 2)
            }
        }
    }
}

struct ImagePreview_Previews: PreviewProvider {
    static let image = UIImage(named: "01")
    static var previews: some View {
        ImagePreview(viewModel: EditorViewModel(), image: image!)
    }
}
