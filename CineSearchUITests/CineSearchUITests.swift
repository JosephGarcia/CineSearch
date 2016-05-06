//
//  CineSearchUITests.swift
//  CineSearchUITests
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import XCTest

class CineSearchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containingType(.StaticText, identifier:"Star Wars: The Force Awakens").childrenMatchingType(.Image).element.tap()
        app.navigationBars["Star Wars: The Force Awakens"].buttons["icon back"].tap()
        cellsQuery.otherElements.containingType(.StaticText, identifier:"Batman v Superman: Dawn of Justice").childrenMatchingType(.Image).element.tap()
        app.navigationBars["Batman v Superman: Dawn of Justice"].buttons["icon back"].tap()
        
        let collectionView = app.otherElements.containingType(.NavigationBar, identifier:"Home").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.CollectionView).element
        collectionView.swipeUp()
        collectionView.swipeUp()
        cellsQuery.otherElements.containingType(.StaticText, identifier:"Dirty Grandpa").childrenMatchingType(.Image).element.tap()
        app.navigationBars["Dirty Grandpa"].buttons["icon back"].tap()
        app.navigationBars["Home"].buttons["Search"].tap()
        
        let searchMoviesSearchField = app.searchFields["Search Movies"]
        searchMoviesSearchField.tap()
        searchMoviesSearchField.typeText("Dead")
        
        let searchButton = app.buttons["Search"]
        searchButton.tap()
        let collectionView2 = app.otherElements.containingType(.NavigationBar, identifier:"Search").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.CollectionView).element
        collectionView2.swipeUp()
        cellsQuery.otherElements.containingType(.StaticText, identifier:"Dead Silence").childrenMatchingType(.Image).element.tap()
        app.navigationBars["Dead Silence"].buttons["icon back"].tap()
        collectionView2.tap()
        searchMoviesSearchField.buttons["Clear text"].tap()
        searchMoviesSearchField.typeText("Gghdd")
        searchButton.tap()
        
    }
    
}
