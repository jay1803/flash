//
//  SendButton.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/9.
//

import SwiftUI

struct SendButton: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @ObservedObject var viewModel: EditorViewModel
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
                        attachment.fileType = "jpg"
                        attachment.fileName = imageData.id
                        saveToPNG(image: imageData.image, name: attachment.fileName)
                        newEntry.attachments.append(attachment)
                    }
                }
                if let entry = parentEntry {
                    realmManager.replyTo(entry: entry, with: newEntry)
                } else {
                    realmManager.add(entry: newEntry)
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
        SendButton(viewModel: EditorViewModel(), parentEntry: .constant(Entry()))
            .environmentObject(RealmManager(name: "flash"))
            .environmentObject(EditorViewModel())
    }
}
