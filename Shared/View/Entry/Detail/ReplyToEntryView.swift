//
//  ReplyToEntryView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import SwiftUI

struct ReplyToEntryView: View {
    
    let replyTo: Entry
    @State private var rowHeight: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            if let replyToEntry = replyTo.replyTo {
                ReplyToEntryView(replyTo: replyToEntry)
            }
            
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .frame(width: 4)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                
                EntryContentView(entry: replyTo)
                    .padding(.vertical, 10)
                    .background(GeometryReader {geometry in
                        Color.clear.preference(key: textViewHeight.self, value: geometry.frame(in: .local).size.height)
                    })
                
                Spacer()
            }
            .frame(height: rowHeight)
            .onPreferenceChange(textViewHeight.self) { rowHeight = $0 }
        }
    }
}

struct ReplyToEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ReplyToEntryView(replyTo: Entry(content: "This is a reply to entry.", replyTo: Entry(content: "This is a reply")))
    }
}
