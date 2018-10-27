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
        print(json)
//        let name = json["name"].stringValue
//        let star = json["star"].intValue
//        let locationJSON = json["location"].json
//        let lat = locationJSON["lat"].floatValue
//        let lng = locationJSON["lng"].floatValue
//        let breakfast = json["breakfast"].bool
//        let rooms = json["rooms"].stringArray
    }
    
}
