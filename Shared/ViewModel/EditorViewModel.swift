//
//  EditorViewModel.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/9.
//

import Foundation
import SwiftUI

final class EditorViewModel: ObservableObject {
    @Published var initHeight: CGFloat = 36
    @Published var height: CGFloat = 36
    @Published var content: String = ""
    @Published var entry: Entry?
    @Published var showImagePicker: Bool = false
    @Published var image: UIImage?
    
    private var documentDirectoryPath: URL? {
        return cwd!.appendingPathComponent("attachments")
    }
    var attachmentFileName: String = UUID().uuidString
    
    init(entry: Entry? = nil) {
        self.entry = entry
    }
    
    func saveToPNG() {
        print(documentDirectoryPath!)
        if !FileManager.default.fileExists(atPath: documentDirectoryPath!.path) {
            do {
                try FileManager.default.createDirectory(at: documentDirectoryPath!,
                                                        withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
            }
        }
        if let PNG = self.image!.pngData(),
        let path = self.documentDirectoryPath?.appendingPathComponent("\(attachmentFileName).png") {
            try? PNG.write(to: path)
        }
    }
}
