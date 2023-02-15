//
//  Thumbnail.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/16.
//

import SwiftUI

struct Thumbnail: View {
    let attachments: [Attachment]
    
    var body: some View {
        HStack {
            ForEach(attachments, id: \.fileName) { attachment in
                if let filePath = getImageFilePath(.thumbnail, of: attachment) {
                    if FileManager.default.fileExists(atPath: filePath.path) {
                        Image(uiImage: UIImage(contentsOfFile: filePath.path)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 64)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                    }
                }
            }
        }
    }
}

struct Thumbnail_Previews: PreviewProvider {
    static var previews: some View {
        Thumbnail(attachments: [Attachment()])
    }
}
