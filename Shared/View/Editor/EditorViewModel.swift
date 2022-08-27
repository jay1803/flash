//
//  EditorViewModel.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/9.
//

import Foundation
import SwiftUI
import RealmSwift

struct ImageData: Identifiable {
    var id: String = UUID().uuidString
    var image: UIImage
    
}

final class EditorViewModel: ObservableObject {
    @Published var initHeight: CGFloat = 36
    @Published var height: CGFloat = 36
    @Published var content: String
    @Published var quoteContent: String?
    @Published var entry: Entry?
    @Published var showImagePicker: Bool = false
    @Published var images: [UIImage] = []
    
    private let realm = RealmManager.shared
    var attachments: [ImageData] {
        images.map({ ImageData(image: $0) })
    }
    
    private var documentDirectoryPath: URL? {
        return docDir!.appendingPathComponent("attachments")
    }
    
    init(content: String = "") {
        self.content = content
    }
    
    func add(entry: Entry) {
        realm.add(entry: entry)
    }
    
    func replyTo(entry: Entry, reply: Entry) {
        realm.replyTo(entry: entry, with: reply)
    }
}
