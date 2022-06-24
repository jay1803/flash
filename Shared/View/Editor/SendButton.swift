//
//  SendButton.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/9.
//

import SwiftUI

struct SendButton: View {

    @ObservedObject var viewModel: EditorViewModel
    @ObservedObject var entryListViewModel: EntryListViewModel
    @State var showingAlert: Bool = false
    
    @Binding var parentEntry: Entry?
    
    var body: some View {
        Button(action: {
            let content = viewModel.content.trimmingCharacters(in: .whitespacesAndNewlines)
            if content.isEmpty {
                showingAlert.toggle()
            } else {
                let newEntry = Entry(content: viewModel.content)
                if let _ = viewModel.images.first {
                    
                    for imageData in viewModel.attachments {
                        let attachment = Attachment()
                        attachment.type = "image"
                        attachment.path = "\(imageData.id).jpg"
                        saveToJPG(image: imageData.image, path: attachment.path)
                        newEntry.attachments.append(attachment)
                    }
                }
                if let entry = parentEntry {
                    viewModel.replyTo(entry: entry, reply: newEntry)
                } else {
                    entryListViewModel.add(entry: newEntry)
                }
            }
            viewModel.content = ""
            viewModel.height = viewModel.initHeight
            viewModel.images = []
        }) {
            IconButton(systemName: "arrow.up.circle.fill",
                       height: viewModel.initHeight,
                       foregroundColor: Color.green)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Content cannot be empty"),
                  message: Text("Try to add some text to the content"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        SendButton(viewModel: EditorViewModel(), entryListViewModel: EntryListViewModel(), parentEntry: .constant(Entry()))
            .environmentObject(EditorViewModel())
    }
}
