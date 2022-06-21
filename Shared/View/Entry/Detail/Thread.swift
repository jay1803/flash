//
//  ReplyToEntryView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import SwiftUI

struct Thread: View {
    
    @Environment(\.colorScheme) var appearance
    
    let replyTo: Entry
    @State private var rowHeight: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            if let replyToEntry = replyTo.replyTo {
                Thread(replyTo: replyToEntry)
            }
            
            HStack(alignment: .top, spacing: 8) {
                Rectangle()
                    .frame(width: 4)
                    .padding(.leading, 0)
                    .foregroundColor(appearance == .dark
                                     ? Color(red: 1, green: 1, blue: 1, opacity: 0.38)
                                     : Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                
                EntryContent(entry: replyTo, font: .body)
                
                Spacer()
            }
        }
    }
}

struct ReplyToEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Thread(replyTo: Entry(content: "This is a reply to entry.", replyTo: Entry(content: "This is a reply")))
    }
}
