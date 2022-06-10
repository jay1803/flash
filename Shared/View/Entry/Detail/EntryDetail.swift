//
//  ThreadDetailView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/3.
//

import SwiftUI
import RealmSwift

struct EntryDetail: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var entry: Entry
    @State var inputText: String = ""
    @State var isPresentingEditView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section {
                    if let replyToEntry = entry.replyTo {
                        Thread(replyTo: replyToEntry)
                    }
                    
                    EntryContent(entry: entry, font: .title3)
                        .frame(height: 300)
                }
                
                
                if !entry.replies.isEmpty {
                    Section(header: Text("Replies")) {
                        ForEach(entry.replies) { reply in
                            EntryRow(entry: reply)
                        }
                    }
                }
            }
            .padding(.bottom, 48)
            
            EntryEditor(parentEntry: entry)
                .environmentObject(realmManager)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            inputText = entry.content
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Edit") {
                    isPresentingEditView = true
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                UpdateEditor(inputText: $inputText)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                                inputText = entry.content
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingEditView = false
                                let modifiedEntry = Entry(id: entry.id, content: inputText, createdAt: entry.createdAt)
                                realmManager.update(entry: modifiedEntry)
                            }
                        }
                    }
            }
        }
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetail(entry: Entry(content: "This is a preview notes\nwith a second lineWoke up to the shattering news that my AJA colleague Shireen is dead - shot in the head, while doing her job. She was brave, warm, and committed to her job.Deepest condolences to her family and her colleagues, who have some bleak, tough days ahead.\nWoke up to the shattering news that my AJA colleague Shireen is dead - shot in the head, while doing her job. She was brave, warm, and committed to her job.Deepest condolences to her family and her colleagues, who have some bleak, tough days ahead."))
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            .environmentObject(RealmManager(name: "flash"))
    }
}
