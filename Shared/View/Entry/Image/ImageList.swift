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
    private let fileDir: URL? = cwd!.appendingPathComponent("attachments")
    
    var body: some View {
        if let attchment = entry.attachments.first {
            let imagePath = fileDir?.appendingPathComponent("\(attchment.fileName).\(attchment.fileType)")
            let image = UIImage(contentsOfFile: imagePath!.path)
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 100)
        }
    }
}

struct ImageList_Previews: PreviewProvider {
    static var previews: some View {
        ImageList(entry: Entry())
    }
}
