//
//  ThreadDetailView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/3.
//

import SwiftUI
import RealmSwift

struct EntryDetail: View {
    @ObservedObject var viewModel: EntryDetailViewModel
    @State var inputText: String = ""
    @State var isPresentingEditView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section {
                    // MARK: - ReplyTo
                    if let replyToEntry = viewModel.entry!.replyTo {
                        Thread(replyTo: replyToEntry)
                    }
                    
                    // MARK: - Content
                    EntryContent(entry: viewModel.entry!, font: .title3)
                }
                
                // MARK: - Replies
                if !viewModel.entry!.replies.isEmpty {
                    Section(header: Text("Replies")) {
                        ForEach(viewModel.entry!.replies) { reply in
                            EntryRow(entry: reply)
                        }
                    }
                }
            }
            .padding(.bottom, 48)
            
            EntryEditor(parentEntry: viewModel.entry)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            inputText = viewModel.entry!.content
            viewModel.setupObserver()
        }
        .onDisappear {
            viewModel.invalidate()
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Edit") {
                    isPresentingEditView = true
                }
            }
        }
        // MARK: - Edit Model
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                UpdateEditor(inputText: $inputText)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                                inputText = viewModel.entry!.content
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingEditView = false
                                let modifiedEntry = Entry(id: viewModel.entry!.id, content: inputText, createdAt: viewModel.entry!.createdAt)
                                viewModel.update(entry: modifiedEntry)
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
    }
}
