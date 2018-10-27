//
//  JSON.swift
//  JSON
//
//  Copyright © 2018 AGGWIN. All rights reserved.
//

import Foundation

public enum Type: Int {
    case string
    case stringArray
    case int
    case intArray
    case double
    case doubleArray
    case bool
    case boolArray
    case any
    case anyArray
    case null
}

public struct JSON {
    
    public let data: Data

    public init(data: Data) {
        self.data = data
    }

    /// Private object
    fileprivate var rawString: String = ""
    fileprivate var rawInt: Int = 0
    fileprivate var rawDouble: Double = 0.0
    fileprivate var rawBool: Bool = false
    fileprivate var rawNull: NSNull = NSNull()
    
    /// JSON type, fileprivate setter
    public fileprivate(set) var type: Type = .null
    
    /// JSON error
    
    /// Object in JSON
    public var object: Any {
        get {
            switch self.type {
            case .string:
                return rawString
            case .int:
                return rawInt
            case .double:
                return rawDouble
            case .bool:
                return rawBool
            default:
                return rawNull
            }
        }
    }
    
}

// MARK: - String

extension JSON {
    
    // Optional
    public var string: String? {
        get {
            switch self.type {
            case .string:
                return object as? String
            default:
                return nil
            }
        }
    }
    
    // Non-optional
    public var stringValue: String {
        get {
            switch self.type {
            case .string:
                return object as? String ?? ""
            case .int:
                return "\(self.rawInt)"
            default:
                return ""
            }
        }
    }
    
}

// MARK: - Int

extension JSON {
    
    // Optional
    public var int: Int? {
        get {
            switch self.type {
            case .int:
                return object as? Int
            default:
                return nil
            }
        }
    }
    
    // Non-optional
    public var intValue: Int {
        get {
            switch self.type {
            case .int:
                return object as? Int ?? 0
            default:
                return 0
            }
        }
    }
    
}
