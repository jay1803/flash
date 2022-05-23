//
//  EditorViewModel.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/9.
//

import Foundation
import SwiftUI

struct ImageData: Identifiable {
    var id: String = UUID().uuidString
    var image: UIImage
}

final class EditorViewModel: ObservableObject {
    @Published var initHeight: CGFloat = 36
    @Published var height: CGFloat = 36
    @Published var content: String = ""
    @Published var entry: Entry?
    @Published var showImagePicker: Bool = false
    @Published var images: [UIImage] = []
    var attachments: [ImageData] {
        images.map({ ImageData(image: $0) })
    }
    
    private var documentDirectoryPath: URL? {
        return docDir!.appendingPathComponent("attachments")
    }
    var attachmentFileName: String = UUID().uuidString
}
