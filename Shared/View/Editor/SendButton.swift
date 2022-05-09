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
    
    let initHeight: CGFloat
    
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
            viewModel.height = initHeight
        }) {
            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .frame(width: initHeight - CGFloat(4),
                       height: initHeight - CGFloat(4))
                .padding(.trailing, 2)
                .padding(.bottom, 2)
                .foregroundColor(.green)
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
        SendButton(viewModel: EditorViewModel(), initHeight: CGFloat(38))
            .environmentObject(RealmManager(name: "flash"))
    }
}
