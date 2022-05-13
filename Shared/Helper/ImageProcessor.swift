//
//  ImageProcessor.swift
//  flash
//
//  Created by Max Zhang on 2022/5/13.
//

import Foundation
import UIKit

func saveToPNG(image: UIImage, name: String) {
    let path = CWD?.appendingPathComponent("attachments")
    if !FileManager.default.fileExists(atPath: path!.path) {
        do {
            try FileManager.default.createDirectory(at: path!,
                                                    withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    if let PNG = image.pngData(),
    let path = path?.appendingPathComponent("\(name).png") {
        try? PNG.write(to: path)
    }
}
