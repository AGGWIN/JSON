//
//  JSONTests.swift
//  JSONTests
//
//  Copyright © 2018 AGGWIN. All rights reserved.
//

import XCTest
@testable import JSON

class JSONTests: XCTestCase {
    
    var sut: JSON!

    override func setUp() {
        super.setUp()
        
        sut = JSON(data: Data())
    }

    func testInit() {
        XCTAssertEqual(sut.data, Data())
    }

}
