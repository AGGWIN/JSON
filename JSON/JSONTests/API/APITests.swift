//
//  APITests.swift
//  JSON
//
//  Copyright © 2018 AGGWIN. All rights reserved.
//

import XCTest
import JSON

class JSONAPITests: XCTestCase {
    
    var sut: JSON!

    override func setUp() {
        super.setUp()
        
        sut = JSON(data: Data())
    }
    
    func testInit() {
        XCTAssertNotNil(sut)
    }

}
