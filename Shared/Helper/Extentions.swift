//
//  Extentions.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import Foundation

func toString(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: date)
}

var docDir: URL? {
    var docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let groupDir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.maxos.flash")
    if groupDir != nil {
        docDir = groupDir!
    }
    return docDir
}

enum AttachmentSourceType {
    case origin, thumbnail
}

/*
 - file: String, equals fileName + '.' + fileType
 */

func getImageFilePath(_ attachmentSourceType: AttachmentSourceType, of file: Attachment) -> URL {
    var dirPath: URL = docDir!.appendingPathComponent("attachments")
    if attachmentSourceType == AttachmentSourceType.thumbnail {
        dirPath = docDir!.appendingPathComponent("thumbnails")
    }
    let attachmentFilePath = dirPath.appendingPathComponent("\(file.path)")
    print(attachmentFilePath.path)
    return attachmentFilePath
}
