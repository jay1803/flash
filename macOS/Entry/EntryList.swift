//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct EntryList: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @State private var isShowingDeleteAlert: Bool = false
    @State private var deleteItemIndexSet: IndexSet?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(realmManager.entries) { entry in
                    if !entry.isInvalidated {
                        EntryRow(realmManager: realmManager, entry: entry)
                    }
                }
                .onDelete(perform: deleteConfirmation)
            }
            .animation(.easeInOut, value: realmManager.entries)
            .padding(.bottom, 48)
            .frame(minWidth: 300)
            
            EntryEditor(entry: nil)
        }
    }
    
    func deleteConfirmation(at indexSet: IndexSet) {
        self.deleteItemIndexSet = indexSet
        self.isShowingDeleteAlert = true
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        EntryList()
            .environmentObject(RealmManager(name: "flash"))
    }
}
