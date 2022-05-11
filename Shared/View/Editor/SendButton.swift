//
//  SendButton.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/9.
//

import SwiftUI

struct SendButton: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var viewModel: EditorViewModel
    @State var showingAlert: Bool = false
    
    var body: some View {
        Button(action: {
            let content = viewModel.content.trimmingCharacters(in: .whitespacesAndNewlines)
            if content.isEmpty {
                showingAlert.toggle()
            } else {
                let newEntry = Entry(content: viewModel.content)
                if let _ = viewModel.image {
                    let attachment = Attachment()
                    attachment.fileType = "png"
                    attachment.fileName = viewModel.attachmentFileName
                    newEntry.attachments.append(attachment)
                    viewModel.saveToPNG()
                }
                if let entry = viewModel.entry {
                    realmManager.replyTo(entry: entry, with: newEntry)
                } else {
                    realmManager.add(entry: newEntry)
                }
            }
            viewModel.content = ""
            viewModel.height = viewModel.initHeight
        }) {
            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .frame(width: viewModel.initHeight,
                       height: viewModel.initHeight)
                .foregroundColor(.green)
                .background(Color.white)
                .cornerRadius(viewModel.initHeight / 2)
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
        SendButton()
            .environmentObject(RealmManager(name: "flash"))
            .environmentObject(EditorViewModel())
    }
}
