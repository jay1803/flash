//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct EntryListView: View {
    @ObservedRealmObject var entryList: EntryList
    @ObservedObject var viewModel: EntryListViewModel
    @State private var isShowingDeleteAlert: Bool = false
    @State private var deleteItemIndexSet: IndexSet?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.entries!.first != nil {
                List {
                    ForEach(viewModel.entries!) { entry in
                        EntryRowView(entry: entry, entryList: entryList)
                            .actionSheet(isPresented: $isShowingDeleteAlert) {
                                ActionSheet(title: Text("Permanently delete this note?"),
                                            message: Text("You can't undo this action."),
                                            buttons: [
                                                .destructive(Text("Delete"), action: {
                                                    $entryList.items.remove(atOffsets: deleteItemIndexSet!)
                                                }),
                                                .cancel(Text("Cancel"), action: {
                                                    self.isShowingDeleteAlert = false
                                                })
                                ])
                            }
                    }
                    .onDelete(perform: deleteConfirmation)
                }
                .navigationTitle("Notes")
                .navigationBarItems(leading: EditButton())
                .animation(.easeInOut, value: viewModel.entries)
                .listStyle(.inset)
                .padding(.bottom, 48)
            } else {
                EmptyEntryView()
            }
            EntryEditorView()
        }
    }
    
    func deleteConfirmation(at indexSet: IndexSet) {
        self.deleteItemIndexSet = indexSet
        self.isShowingDeleteAlert = true
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(entryList: EntryList(), viewModel: EntryListViewModel())
    }
}
