//
//  FileLoader.swift
//  JSON
//
//  Copyright © 2018 AGGWIN. All rights reserved.
//

import XCTest

class FileLoader {
    
    fileprivate typealias File = (name: String, type: String)
    
    private init() {}
    
    static func data(from resource: String) -> Data {
        let file = FileLoader.checkType(for: resource)
        let fileURL = FileLoader.getURL(for: file)
        
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Convert JSON to Data failed!")
        }
        return data
    }
    
    static func string(from resource: String) -> String {
        let file = FileLoader.checkType(for: resource)
        let fileURL = FileLoader.getURL(for: file)
        
        guard let string = try? String(contentsOf: fileURL, encoding: .utf8) else {
            fatalError("Convert JSON to String failed!")
        }
        return string
    }
    
    fileprivate static func checkType(for resource: String) -> File {
        guard let dotIndex = resource.firstIndex(of: ".") else {
            return (resource, "json")
        }
        
        let name = resource.prefix(upTo: dotIndex)
        let type = resource.suffix(from: resource.index(after: dotIndex))
        
        return (String(name), String(type))
    }
    
    fileprivate static func getURL(for file: File) -> URL {
        guard let fileURL = Bundle(for: FileLoader.self).url(forResource: file.name, withExtension: file.type) else {
            fatalError("Load file from bundle failed!")
        }
        return fileURL
    }
    
}

class FileLoaderTests: XCTestCase {
    
    func testCheckType() {
        let file = FileLoader.checkType(for: "Hotel.json")
        XCTAssertEqual(file.name, "Hotel")
        XCTAssertEqual(file.type, "json")
        
        let file2 = FileLoader.checkType(for: "Hotel")
        XCTAssertEqual(file2.name, "Hotel")
        XCTAssertEqual(file2.type, "json")
    }
    
    func testFileURL() {
        let file = FileLoader.checkType(for: "Hotel.json")
        let fileURL = FileLoader.getURL(for: file)
        XCTAssertNotNil(fileURL)
    }
    
    func testData() {
        let fileData = FileLoader.data(from: "Hotel")
        XCTAssertNotNil(fileData)
    }
    
    func testString() {
        let fileString = FileLoader.string(from: "Hotel")
        XCTAssert(fileString.contains("Sheraton"))
    }
    
}
