//
//  ImageList.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/11.
//

import SwiftUI
import RealmSwift

struct ImageList: View {
    
    @ObservedRealmObject var entry: Entry
    var maxHeight: CGFloat
    private let fileDir: URL? = CWD!.appendingPathComponent("attachments")
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(entry.attachments, id: \.fileName) { attachment in
                    let imagePath = fileDir!.appendingPathComponent("\(attachment.fileName).\(attachment.fileType)")
                    let image = UIImage(contentsOfFile: imagePath.path)
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: maxHeight)
                }
            }
        }
    }
}

struct ImageList_Previews: PreviewProvider {
    static var previews: some View {
        ImageList(entry: Entry(), maxHeight: 300)
    }
}
