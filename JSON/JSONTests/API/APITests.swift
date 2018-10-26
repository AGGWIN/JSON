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
    let hotelData = FileLoader.data(from: "Hotel")

    override func setUp() {
        super.setUp()

        sut = JSON(data: hotelData)
    }
    
    func testInit() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.data, hotelData)
    }

}
