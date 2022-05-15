//
//  IconButton.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/11.
//

import SwiftUI

struct IconButton: View {
    let systemName: String
    let height: CGFloat
    let foregroundColor: Color

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .frame(width: height, height: height)
            .foregroundColor(foregroundColor)
            .background(Color.white)
            .cornerRadius(height / 2)
    }
}
