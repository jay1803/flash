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

var cwd: URL? {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
}
