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
    @Environment(\.colorScheme) var appearance
    @State var inputText: String = ""
    @State var isPresentingEditView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section {
                    // MARK: - ReplyTo
                    if let replyToEntry = viewModel.entry!.replyTo {
                        HStack(alignment: .top, spacing: 8) {
                            Rectangle()
                                .frame(width: 4)
                                .padding(.leading, 0)
                                .foregroundColor(appearance == .dark
                                                 ? Color(red: 1, green: 1, blue: 1, opacity: 0.38)
                                                 : Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                            Thread(replyTo: replyToEntry)
                        }
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
    static let entry = Entry(content: "Some content")
    static let viewModel = EntryDetailViewModel(id: UUID())

    static var previews: some View {
        EntryDetail(viewModel: viewModel)
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
}
