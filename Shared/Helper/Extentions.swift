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

enum AttachmentType {
    case origin, thumbnail
}

/*
 - file: String, equals fileName + '.' + fileType
 */

func getImageFilePath(_ attachmentType: AttachmentType, of file: Attachment) -> URL {
    let fileName = "\(file.fileName).\(file.fileType)"
    var dirPath: URL = CWD!.appendingPathComponent("attachments")
    if attachmentType == AttachmentType.thumbnail {
        dirPath = CWD!.appendingPathComponent("thumbnails")
    }
    let attachmentFilePath = dirPath.appendingPathComponent("\(fileName)")
    print(attachmentFilePath.path)
    return attachmentFilePath
}
