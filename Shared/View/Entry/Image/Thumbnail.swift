//
//  Thumbnail.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/16.
//

import SwiftUI

struct Thumbnail: View {
    let entry: Entry
    
    var body: some View {
        HStack {
            if !entry.attachments.isEmpty {
                ForEach(entry.attachments, id: \.fileName) { attchment in
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 12)
                }
            }
        }
    }
}

struct Thumbnail_Previews: PreviewProvider {
    static var previews: some View {
        Thumbnail(entry: Entry())
    }
}
