//
//  EntryContentView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import SwiftUI
import RealmSwift

struct EntryContent: View {
    @ObservedRealmObject var entry: Entry
    @State var calculatedHeight: CGFloat = 40
    @Binding var selectedContent: String?
    @Binding var isPresentingQuoteView: Bool
    let fontSize: CGFloat
    
    private let fileDir: URL? = docDir!.appendingPathComponent("attachments")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            EntryCreationDateTime(entryCreatedAt: entry.createdAt)
            
            EntryTextView(content: $entry.content,
                          calculatedHeight: $calculatedHeight,
                          selectedContent: $selectedContent,
                          isPresentingQuoteView: $isPresentingQuoteView,
                          fontSize: fontSize)
                .frame(minHeight: calculatedHeight, maxHeight: calculatedHeight)
            
            if !entry.attachments.isEmpty {
                VStack {
                    ForEach(entry.attachments, id: \.path) { attachment in
                        let imagePath = fileDir!.appendingPathComponent(attachment.path)
                        let image = UIImage(contentsOfFile: imagePath.path)
                        Image(uiImage: image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            
            if let quoteContent = entry.quote {
                Text(quoteContent)
            }
        }
        .padding(.vertical, 8)
    }
}

struct EntryContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        EntryContent(entry: Entry(content: "This is a preview notes\nwith a second lineWoke up to the shattering news that my AJA colleague Shireen is dead - shot in the head, while doing her job. She was brave, warm, and committed to her job.Deepest condolences to her family and her colleagues, who have some bleak, tough days ahead.\nWoke up to the shattering news that my AJA colleague Shireen is dead - shot in the head, while doing her job. She was brave, warm, and committed to her job.Deepest condolences to her family and her colleagues, who have some bleak, tough days ahead."), selectedContent: .constant(nil), isPresentingQuoteView: .constant(false), fontSize: 19)
    }
}
