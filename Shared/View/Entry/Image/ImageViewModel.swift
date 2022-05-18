//
//  EntryListViewModel.swift
//  flash
//
//  Created by Max Zhang on 2022/5/17.
//

import Foundation
import UIKit

struct ImageViewModel {
    var entry: Entry
    var attachmentType: AttachmentType
    var images: [UIImage]?
    
    init(entry: Entry, attachmentType: AttachmentType) {
        self.entry = entry
        self.attachmentType = attachmentType
        self.images = getImages()
    }
    
    func getImages() -> [UIImage] {
        if entry.attachments.isEmpty {
            return []
        }
        let attachments = entry.attachments
        var images: [UIImage] = []
        for attachment in attachments {
            guard let image = getAttachment(attachmentType, of: "\(attachment.fileName).\(attachment.fileType)") else {
                return []
            }
            images.append(image)
        }
        return images
    }
    
    enum AttachmentType {
        case origin, thumbnail
    }
    
    /*
     - file: String, equals fileName + '.' + fileType
     */
    
    private func getAttachment(_ attachmentType: AttachmentType, of file: String) -> UIImage? {
        var dirPath: URL = CWD!.appendingPathComponent("attachments")
        if attachmentType == AttachmentType.thumbnail {
            dirPath = CWD!.appendingPathComponent("thumbnails")
        }
        let attachmentFile = dirPath.appendingPathComponent("\(file)")
        let image = UIImage(contentsOfFile: attachmentFile.path)
        return image
    }
}
