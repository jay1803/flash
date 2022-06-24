//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI

struct EntryList: View {
    
    @ObservedObject var viewModel = EntryListViewModel()
    @State private var isShowingDeleteAlert: Bool = false
    @State private var deleteItemIndexSet: IndexSet?
    @State private var isImageSaved = true
    
    var body: some View {
        if viewModel.entries.first != nil {
            List {
                ForEach(viewModel.entries) { entry in
                    if !entry.isInvalidated {
                        EntryRow(entry: entry)
                            .actionSheet(isPresented: $isShowingDeleteAlert) {
                                ActionSheet(title: Text("Permanently delete this note?"),
                                            message: Text("You can't undo this action."),
                                            buttons: [
                                                .destructive(Text("Delete"), action: {
                                                    let entry = viewModel.entries[deleteItemIndexSet!.first!]
                                                    viewModel.remove(entry: entry)
                                                }),
                                                .cancel(Text("Cancel"), action: {
                                                    self.isShowingDeleteAlert = false
                                                })
                                ])
                        }
                    }
                }
                .onDelete(perform: deleteConfirmation)
            }
            .navigationTitle("Notes")
            .navigationBarItems(leading: EditButton())
            .animation(.easeInOut, value: viewModel.entries)
            .listStyle(.inset)
            .padding(.bottom, 48)
            .onAppear(perform: {
                viewModel.fetch()
            })
            .onDisappear(perform: {
                viewModel.invalidate()
            })
        } else {
            EmptyEntry()
                .onAppear(perform: {
                    viewModel.fetch()
                })
        }
    }
    
    func deleteConfirmation(at indexSet: IndexSet) {
        self.deleteItemIndexSet = indexSet
        self.isShowingDeleteAlert = true
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        EntryList()
    }
}
