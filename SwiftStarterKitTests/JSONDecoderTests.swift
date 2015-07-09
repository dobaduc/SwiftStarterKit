///
//  JSONDecoderTests.swift
//  SwiftStarterKit
//
//  Created by Doba Duc on 7/9/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

// NOTE: This file is actually my JSON decoding study note
// Reference: Box, Argo, Himotoki

import XCTest


class JSONDecoderTests: XCTestCase {
    func testJSONDecoding() {

        let JSON = [
            ["name": "Jamie", "age": 18, "postCount": 100],
            ["name": "Tonny", "age": 28, "postCount": 40]
        ]
    }
}


// MARK:- Inspired by Box
public protocol ValueWrapper {
    typealias ValueType

    init(value: ValueType)
    var primitiveValue: ValueType { get set }
}


public final class ValueContainer<T>: ValueWrapper, Printable {
    var value: T

    // MARK:- ValueWrapper protocol
    public init(value: T) {
        self.value = value
    }

    public var primitiveValue: T {
        get {
            return self.value
        }
        set {
            self.value = newValue
        }
    }

    // MARK:- Printable protocol
    public var description: String {
        return "\(self.value)"
    }
}

// MARK:- Inspired by Argo
public enum Decoded<T> {
    case Success(ValueContainer<T>)
    case Failure

    public var value: T? {
        switch self {
        case let .Success(valueContainer): return valueContainer.value
        default: return .None
        }
    }
}

public extension Decoded {
    static func optional<T>(x: Decoded<T>) -> Decoded<T?> {
        switch x {
        case let .Success(valueContainer): return .Success(ValueContainer(value: .Some(valueContainer.value)))
        default: return .Failure
        }
    }

    static func fromOptional<T>(x: T?) -> Decoded<T> {
        switch x {
        case let .Some(valueContainer): return .Success(ValueContainer(value: valueContainer))
        default: return .Failure
        }
    }
}

protocol Decodable {
    typealias DecodedType = Self
    static func decode(json: JSON) -> Decoded<DecodedType>
}


extension String: Decodable {
    public static func decode(j: JSON) -> Decoded<String> {
        switch j {
        case let .String(s): return .Success(ValueContainer(value: s))
        default: return .Failure
        }
    }
}

extension Int: Decodable {
    public static func decode(j: JSON) -> Decoded<Int> {
        switch j {
        case let .Number(n): return .Success(ValueContainer(value: n as Int))
        default: return .Failure
        }
    }
}


// MARK:- map, apply, flatmap,...
public extension Decoded {

    //    func map<U>(f: T -> U) -> Decoded<U> {
    //        switch self {
    //        case let .Success(valueContainer): return .Success(valueContainer(f(valueContainer.value)))
    //        case let .Failure: return .Failure
    //        }
    //    }
    //
    //    func apply<U>(f: Decoded<T -> U>) -> Decoded<U> {
    //        switch f {
    //        case let .Success(box): return box.value <^> self
    //        case let .MissingKey(string): return .MissingKey(string)
    //        case let .TypeMismatch(string): return .TypeMismatch(string)
    //        }
    //    }
    //
    //    func flatMap<U>(f: T -> Decoded<U>) -> Decoded<U> {
    //        switch self {
    //        case let .Success(box): return f(box.value)
    //        case let .MissingKey(string): return .MissingKey(string)
    //        case let .TypeMismatch(string): return .TypeMismatch(string)
    //        }
    //    }
}


public enum JSON {
    case Object([Swift.String: JSON])
    case Array([JSON])
    case String(Swift.String)
    case Number(NSNumber)
    case Null
}

// MARK:- Test classes
//struct Blogger: Decodable {
//    let name: String
//    let age: Int
//    let postCount: Int
//
//    static func decode(json: JSON) -> Decoded<Blogger> {
//
//    }
//}