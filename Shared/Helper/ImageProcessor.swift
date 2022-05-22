//
//  ImageProcessor.swift
//  flash
//
//  Created by Max Zhang on 2022/5/13.
//

import Foundation
import UIKit

func saveToJPG(image: UIImage, path: String) {
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
    
    if let originJPG = image.jpegData(compressionQuality: 1),
       let thumbnailImage = image.jpegData(compressionQuality: 0.01) {
        DispatchQueue.global().async {
            try? originJPG.write(to: originAttachmentsPath!.appendingPathComponent(path))
            try? thumbnailImage.write(to: imageThumbnailPath!.appendingPathComponent(path))
        }
    }
}
