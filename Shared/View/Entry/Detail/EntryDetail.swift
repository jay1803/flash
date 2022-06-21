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
    @ObservedObject var viewModel: EntryDetailViewModel
    @State var inputText: String = ""
    @State var isPresentingEditView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section {
                    if let replyToEntry = viewModel.entry.replyTo {
                        Thread(replyTo: replyToEntry)
                    }
                    
                    EntryContent(entry: viewModel.entry, font: .title3)
                }
                
                
                if !viewModel.entry.replies.isEmpty {
                    Section(header: Text("Replies")) {
                        ForEach(viewModel.entry.replies) { reply in
                            EntryRow(entry: reply)
                        }
                    }
                }
            }
            .padding(.bottom, 48)
            
            EntryEditor(parentEntry: viewModel.entry)
                .environmentObject(realmManager)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            inputText = viewModel.entry.content
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
                                inputText = viewModel.entry.content
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingEditView = false
                                let modifiedEntry = Entry(id: viewModel.entry.id, content: inputText, createdAt: viewModel.entry.createdAt)
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
        EntryDetail(viewModel: EntryDetailViewModel(id: UUID()))
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            .environmentObject(RealmManager(name: "flash"))
    }
}
