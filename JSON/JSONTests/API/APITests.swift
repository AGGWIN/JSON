//
//  APITests.swift
//  JSON
//
//  Copyright © 2018 AGGWIN. All rights reserved.
//

import XCTest
import JSON

class JSONAPITests: XCTestCase {
    
    let hotelData = FileLoader.data(from: "Hotel")
    
    func testHotel() {
        let json = JSON(data: hotelData)

        let name = json["name"].stringValue
        XCTAssertEqual(name, "Sheraton")
        let star = json["star"].intValue
        XCTAssertEqual(star, 5)
        
//        let locationJSON = json["location"].json
//        let lat = locationJSON["lat"].floatValue
//        let lng = locationJSON["lng"].floatValue
//        let breakfast = json["breakfast"].bool
//        let rooms = json["rooms"].stringArray
    }
    
}
