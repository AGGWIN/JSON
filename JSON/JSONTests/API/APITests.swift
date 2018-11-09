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
        let json = try! JSON(data: hotelData)

        let name = json["name"].string
        XCTAssertNotNil(name)
        let nameValue = json["name"].stringValue
        XCTAssertEqual(nameValue, "Sheraton")
        
        let star = json["star"].int
        XCTAssertNotNil(star)
        let starValue = json["star"].intValue
        XCTAssertEqual(starValue, 5)
        
//        let locationJSON = json["location"].json
//        let lat = locationJSON["lat"].floatValue
//        let lng = locationJSON["lng"].floatValue
        
        let breakfast = json["breakfast"].bool
        XCTAssertNotNil(breakfast)
        let breakfastValue = json["breakfast"].boolValue
        XCTAssertEqual(breakfastValue, true)
        
        let rooms = json["rooms"].stringArray
        XCTAssertEqual(rooms.count, 4)
    }
    
}
