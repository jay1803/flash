//
//  Tests_EntryList.swift
//  Tests iOS
//
//  Created by Max Zhang on 2022/5/26.
//

import XCTest
import ViewInspector

extension Home: Inspectable { }
extension EmptyEntry: Inspectable { }
extension EntryList: Inspectable { }
extension EntryEditor: Inspectable { }
extension TextInput: Inspectable { }

class Tests_EntryList: XCTestCase {
    
    let app = XCUIApplication()
    let realmManager = RealmManager(name: "testFlash")
    let homeView = Home()
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        ViewHosting.host(view: homeView.environmentObject(realmManager))
        app.launch()
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        realmManager.deleteAll()
    }

    func test_EntryList_Init_ExpectToSeeEmptyList() throws {
        // Given
        ViewHosting.host(view: homeView.environmentObject(realmManager))
        let entryListView = try homeView.inspect().zStack().view(EntryList.self, 0)
        let emptryEntryView = try entryListView.view(EmptyEntry.self)
        let emtryEntryText = try emptryEntryView.geometryReader().text()

        // Then
        XCTAssertFalse(entryListView.isAbsent, "Expected to see entryListView")
        XCTAssertFalse(emptryEntryView.isAbsent, "Expected to see emptryEntryView")
        XCTAssertFalse(emtryEntryText.isAbsent, "Expected to see emptryEntryView")
        XCTAssertEqual(try emtryEntryText.string(), "Start to add some notes here...")
    }

    func test_TextEditor_Init_ExpectHeight() throws {
        // Given
        ViewHosting.host(view: homeView.environmentObject(realmManager))
        let editorGroup = try homeView.inspect().zStack().view(EntryEditor.self, 1)
        let editorView = try editorGroup.vStack().hStack(1)
        let textInput = try editorView.view(TextInput.self, 1)
        let editorHeight = try editorView.fixedHeight()
        // Then
        XCTAssertFalse(editorView.isAbsent)
        XCTAssertEqual(editorHeight, 36)
        XCTAssertFalse(textInput.isAbsent, "Expected to see text input.")
    }
    
    func test_TextEditor_HeightChanges() throws {
        ViewHosting.host(view: homeView.environmentObject(realmManager))
        let editorGroup = try homeView.inspect().zStack().view(EntryEditor.self, 1)
        let editorView = try editorGroup.vStack().hStack(1)
        let textInput = try editorView.view(TextInput.self, 1)
        
        // Then
        XCTAssertFalse(textInput.isAbsent, "Expected to see text input.")
        
    }
}
