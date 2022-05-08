//
//  Blank.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI

struct EmptyEntry: View {
    var body: some View {
        GeometryReader { geometry in
            Text("Start to add some notes here...")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct EmptyEntryView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyEntry()
    }
}
