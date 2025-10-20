//
//  SmartTasksUITests.swift
//  SmartTasksUITests
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import XCTest

final class SmartTasksUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // TODO: Mock the app
    
    @MainActor
    func test_resolvedTask_shouldSave() {
        let app = XCUIApplication()
        app.launch()
        
        let frenchLocalizationStaticText = app.scrollViews.otherElements.staticTexts["French localization"]
        
        frenchLocalizationStaticText
            .tap()
        
        app.buttons["Resolve"]
            .tap()
        
        let resolvedSignImage = app.images["Resolved sign"]
        XCTAssertTrue(resolvedSignImage.exists)
        
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
            /*@START_MENU_TOKEN@*/.buttons["Arrow back"]/*[[".otherElements[\"Arrow back\"].buttons[\"Arrow back\"]",".buttons[\"Arrow back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            .tap()
        frenchLocalizationStaticText.tap()
        
        let alreadyResolved = app.images["Resolved sign"]
        XCTAssertTrue(alreadyResolved.exists)
                                
    }
    
    @MainActor
    func test_cantResolveTask_shouldSave() {
        let app = XCUIApplication()
        app.launch()
        
        let frenchLocalizationStaticText = app.scrollViews.otherElements.staticTexts["French localization"]
        
        frenchLocalizationStaticText
            .tap()
        
        app.buttons["Can't resolve"]
            .tap()
        
        let resolvedSignImage = app.images["Unresolved sign"]
        XCTAssertTrue(resolvedSignImage.exists)
        
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
            /*@START_MENU_TOKEN@*/.buttons["Arrow back"]/*[[".otherElements[\"Arrow back\"].buttons[\"Arrow back\"]",".buttons[\"Arrow back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            .tap()
        frenchLocalizationStaticText.tap()
        
        let alreadyResolved = app.images["Unresolved sign"]
        XCTAssertTrue(alreadyResolved.exists)
                                
    }
    
    
    func test_changingDays() {
        let app = XCUIApplication()
        app.launch()
        let ttgc7swiftui32navigationstackhostingNavigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        let todayStaticText = ttgc7swiftui32navigationstackhostingNavigationBar.staticTexts["Today"]
        XCTAssertTrue(todayStaticText.exists)
        
        let arrowForwardButton = ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["Arrow forward"]/*[[".otherElements[\"Arrow forward\"].buttons[\"Arrow forward\"]",".buttons[\"Arrow forward\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        arrowForwardButton.tap()
        XCTAssertTrue(ttgc7swiftui32navigationstackhostingNavigationBar.staticTexts["Tomorrow"].exists)
        
        let arrowBackButton = ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["Arrow back"]/*[[".otherElements[\"Arrow back\"].buttons[\"Arrow back\"]",".buttons[\"Arrow back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        arrowBackButton.tap()
        arrowBackButton.tap()
        
        XCTAssertTrue(ttgc7swiftui32navigationstackhostingNavigationBar.staticTexts["Yesterday"].exists)
    }
    
}
