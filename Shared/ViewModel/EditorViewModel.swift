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
    @Published var height: CGFloat = 0
    @Published var content: String = ""
    @Published var entry: Entry?
    
    init(entry: Entry? = nil) {
        self.entry = entry
    }
}
