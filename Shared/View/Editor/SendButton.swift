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
                if let entry = viewModel.entry {
                    realmManager.replyTo(entry: entry, with: Entry(content: viewModel.content))
                } else {
                    realmManager.add(entry: Entry(content: viewModel.content))
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
