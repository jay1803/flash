//
//  ImageProcessor.swift
//  flash
//
//  Created by Max Zhang on 2022/5/13.
//

import Foundation
import UIKit

func saveToPNG(image: UIImage, name: String) {
    let originAttachmentsPath = CWD?.appendingPathComponent("attachments")
    let imageThumbnailPath = CWD?.appendingPathComponent("thumbnails")
    
    if !FileManager.default.fileExists(atPath: originAttachmentsPath!.path) {
        do {
            try FileManager.default.createDirectory(at: originAttachmentsPath!,
                                                    withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    if !FileManager.default.fileExists(atPath: imageThumbnailPath!.path) {
        do {
            try FileManager.default.createDirectory(at: imageThumbnailPath!,
                                                    withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    if let originPNG = image.pngData(),
       let thumbnailImage = image.jpegData(compressionQuality: 0.1) {
        DispatchQueue.global().async {
            try? originPNG.write(to: originAttachmentsPath!.appendingPathComponent("\(name).png"))
            try? thumbnailImage.write(to: imageThumbnailPath!.appendingPathComponent("\(name).jpg"))
        }
    }
}
