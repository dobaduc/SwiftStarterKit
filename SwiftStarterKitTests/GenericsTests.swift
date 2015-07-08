//
//  GenericsTests.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 7/7/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import XCTest

class GenericsTests: XCTestCase {

    func testConcatenatableStrings() {
        // Use let
        let x = "1", y = "2"
        let z = x.concat(y)
        XCTAssert(z == "12", "Concatenating result was wrong")

        // Try using string literal directly
        XCTAssert("Swift".concat(" is awesome!") == "Swift is awesome!", "Concatenating result was wrong")
    }

    func testConcatenatableInts() {
        XCTAssert(1.concat(2) == 12, "1 concats 2 should be 12")
        XCTAssert(1.concat(-2) == nil, "1 concats -2 should be nil")
        XCTAssert(1.concat(125) == 1125, "1 concats 125 should be 1125")
        XCTAssert(0.concat(161) == 161, "0 concats 161 should be 161")
        XCTAssert(123.concat(456789) == 123456789, "123 concats 456789 should be 123456789")
    }

    func testConcatenatableArrays() {
        XCTAssert([1].concat([2])! == [1, 2])
        XCTAssert(["A"].concat(["B", "C"])! == ["A", "B", "C"])
        XCTAssert(["Swift", "Is"].concat(["Awesome"])! == ["Swift", "Is", "Awesome"])
    }
}

// MARK:- Protocol and associated operator definition
protocol Concatenatable {
    // Try Associated Type
    // TODO: Confirm if this is the same as: typealias ValueType = Self
    typealias ValueType

    func concat(anotherValue: ValueType) -> ValueType?
}

//// TODO: Play with the operator
//infix operator +++ {}
//func concat<T: Concatenatable where T == Concate> (left: T, right: T) -> T? {
//    return nil
//}

// MARK:- Extend Int
infix operator ^^ {}
func ^^ (number: Int, power: Int) -> Int {
    return Int(pow(Double(number), Double(power)))
}

extension Int: Concatenatable {
    func concat(anotherInt: Int) -> Int? {
        if self == 0 {
            return anotherInt
        }

        if anotherInt < 0 {
            return nil
        }

        var digitCount = 1, remainingValue = anotherInt
        while remainingValue > 10 {
            remainingValue /= 10
            digitCount++
        }

        // TODO: Check for arithmetic overflow exception or try overflow operator &+
        return self * (10 ^^ digitCount) + anotherInt
    }
}

// MARK:- Extend String
extension String: Concatenatable {
    func concat(anotherString: String) -> String? {
        return self + anotherString
    }
}

// MARK:- Extend Array
extension Array: Concatenatable {
    func concat(anotherArray: Array<T>) -> Array<T>? {
        var returnArray = self
        returnArray.extend(anotherArray)

        return returnArray
    }
}