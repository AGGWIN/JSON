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
    case dictionary
    case null
}

public struct JSON {

    public init(data: Data) throws {
        let object: Any = try JSONSerialization.jsonObject(with: data, options: [])
        self.init(jsonObject: object)
    }
    
    public init(_ object: Any) {
        switch object {
        case let object as Data:
            do {
                try self.init(data: object)
            } catch {
                self.init(jsonObject: NSNull())
            }
        default:
            self.init(jsonObject: object)
        }
    }
    
    fileprivate init(jsonObject: Any) {
        self.object = jsonObject
    }

    /// Private object
    fileprivate var rawString: String = ""
    fileprivate var rawInt: Int = 0
    fileprivate var rawDouble: Double = 0.0
    fileprivate var rawBool: Bool = false
    fileprivate var rawArray: [Any] = []
    fileprivate var rawDictionary: [String: Any] = [:]
    fileprivate var rawNull: NSNull = NSNull()
    
    /// JSON type, fileprivate setter
    public fileprivate(set) var type: Type = .null
    
    /// The static null JSON
    public static var null: JSON { return JSON(NSNull())}
    
    /// JSON error
    
    /// Object in JSON
    fileprivate var object: Any {
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
            case .dictionary:
                return rawDictionary
            default:
                return rawNull
            }
        }
        set {
            switch unbox(newValue) {
            case let string as String:
                type = .string
                rawString = string
            case let int as Int:
                type = .int
                rawInt = int
            case let double as Double:
                type = .double
                rawDouble = double
            case let dictionary as [String: Any]:
                type = .dictionary
                rawDictionary = dictionary
            case let bool as Bool:
                type = .bool
                rawBool = bool
            default:
                type = .null
            }
        }
    }
    
    private func unbox(_ object: Any) -> Any {
        switch object {
        case let json as JSON:
            return json.unbox(json.object)
        case let array as [Any]:
            return array.map(unbox)
        case let dictionary as [String: Any]:
            var unboxedDic = dictionary
            for (k, v) in dictionary {
                unboxedDic[k] = unbox(v)
            }
            return unboxedDic
        default:
            return object
        }
    }
    
}

// MARK: - Subscript

public enum JSONKey {
    case index(Int)
    case key(String)
}

public protocol JSONSubscriptType {
    var jsonKey: JSONKey { get }
}

extension Int: JSONSubscriptType {
    public var jsonKey: JSONKey {
        return JSONKey.index(self)
    }
}

extension String: JSONSubscriptType {
    public var jsonKey: JSONKey {
        return JSONKey.key(self)
    }
}

extension JSON {
    
    fileprivate subscript(index index: Int) -> JSON {
        get {
            return .null
        }
        set {
            
        }
    }
    
    fileprivate subscript(key key: String) -> JSON {
        get {
            var result = JSON.null
            if self.type == .dictionary {
                if let value = rawDictionary[key] {
                    result = JSON(value)
                }
            }
            return result
        }
        set {
            
        }
    }
    
    fileprivate subscript(sub sub: JSONSubscriptType) -> JSON {
        get {
            switch sub.jsonKey {
            case .index(let index): return self[index: index]
            case .key(let key): return self[key: key]
            }
        }
        set {
            
        }
    }
    
    public subscript(path: [JSONSubscriptType]) -> JSON {
        get {
            return path.reduce(self) { $0[sub: $1] }
        }
        set {
            switch path.count {
            case 0:
                return
            case 1:
                self[sub: path[0]].object = newValue.object
            default:
                return
            }
        }
    }
    
    public subscript(path: JSONSubscriptType...) -> JSON {
        get {
            return self[path]
        }
        set {
            self[path] = newValue
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

extension JSON {
    
    // Optional
    public var bool: Bool? {
        get {
            switch self.type {
            case .bool:
                return object as? Bool
            default:
                return nil
            }
        }
    }
    
    // Non-optional
    public var boolValue: Bool {
        get {
            switch self.type {
            case .bool:
                return object as? Bool ?? false
            default:
                return false
            }
        }
    }
    
}
