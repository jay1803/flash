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
            
            EntryContent(entry: replyTo,
                         selectedContent: .constant(nil), 
                         isPresentingQuoteView: .constant(false), 
                         font: .body)
        }
    }
}

struct ReplyToEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Thread(replyTo: Entry(content: "This is a reply to entry.", replyTo: Entry(content: "This is a reply")))
    }
}
