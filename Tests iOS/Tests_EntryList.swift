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

class Tests_EntryList: XCTestCase {
    
    let app = XCUIApplication()
    let realmManager = RealmManager(name: "testFlash")
    let homeView = Home()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        realmManager.deleteAll()
        app.launch()
        ViewHosting.host(view: homeView.environmentObject(realmManager))

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        realmManager.deleteAll()
    }

    func test_EntryList_Init_ExpectToSeeEmptyList() throws {
        // Given
        let entryListView = try homeView.inspect().view(EntryList.self)
        let emptryEntryView = try entryListView.zStack().view(EmptyEntry.self, 0)
        let emtryEntryText = try emptryEntryView.geometryReader().text().string()

        // Then
        XCTAssertFalse(entryListView.isAbsent, "Expected to see entryListView")
        XCTAssertFalse(emptryEntryView.isAbsent, "Expected to see emptryEntryView")
        XCTAssertEqual(emtryEntryText, "Start to add some notes here...")
    }

    func test_TextEidotr_Init_ExpectHeight() throws {
        // Given
        
        // When
        
        // Then
            
    }
}
