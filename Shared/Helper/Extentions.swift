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

var CWD: URL? {
    return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.maxos.flash")!
}

enum AttachmentSourceType {
    case origin, thumbnail
}

/*
 - file: String, equals fileName + '.' + fileType
 */

func getImageFilePath(_ attachmentSourceType: AttachmentSourceType, of file: Attachment) -> URL {
    var dirPath: URL = CWD!.appendingPathComponent("attachments")
    if attachmentSourceType == AttachmentSourceType.thumbnail {
        dirPath = CWD!.appendingPathComponent("thumbnails")
    }
    let attachmentFilePath = dirPath.appendingPathComponent("\(file.path)")
    print(attachmentFilePath.path)
    return attachmentFilePath
}
