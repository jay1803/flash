//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Max Zhang on 2022/4/29.
//

import XCTest
@testable import flash
@testable import RealmSwift

// Naming: test_Unit_State_Expectaion

class Tests_iOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let realmManager = RealmManager(name: "testFlash")
        realmManager.deleteAll()
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_Realm_Init_ExpectToBeEmpty() throws {
        // Given
        let realmManager = RealmManager(name: "testFlash")
        // When
        // Then
        XCTAssertEqual(realmManager.entries.count, 0)
        
    }
    
    func test_Realm_AddEntryWithContent_ExpectTheTotalEqualsOne() throws {
        // Given
        let realmManager = RealmManager(name: "testFlash")
        let entry = Entry(content: "testing entry")
        // When
        realmManager.add(entry: entry)
        // Then
        XCTAssertEqual(realmManager.entries.count, 1)
        XCTAssertEqual(realmManager.entries.first?.content, "testing entry")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
