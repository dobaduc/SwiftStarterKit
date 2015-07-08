//
//  ParameterTypeAndReturnTypeTests.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 7/7/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import XCTest

class ParameterTypeAndReturnTypeTests: XCTestCase {

    // MARK:- Play with Tuples

    func testNamedReturnValues() {
        typealias MyType = (min: Int, max: Int)

        func compare(left: Int, right: Int) -> MyType {
            if left < right {
                // Check if it's possible to write the initializer like this
                return MyType(min: left, max: right)
            } else {
                // Return dmmy tuple without initializer
                return (min: right, max: left)
            }
        }

        let result = compare(50, 20)
        XCTAssert(result.min == 20 && result.max == 50, "Comparison result went wrong!")
    }

    func testAnonymousReturnValues() {
        func compare(left: Int, right: Int) -> (Int, Int) {
            if left < right {
                return (left, right)
            } else {
                return (right, left)
            }
        }

        let result = compare(50, 20)
        XCTAssert(result.0 == 20 && result.1 == 50, "Comparison result went wrong!")
    }


    // MARK:- Play with Function type

    func testFunctionTypeAsParameter() {
        // NOTE: the expectation here is not for asynchronous testing, but for demonstrating the closure syntax without parenthesis at the bottom of this method
        let expectation = expectationWithDescription("Function type should work just fine!")

        func addTwoInts(a: Int, b: Int) -> Int {
            return a + b
        }

        func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
            let result = mathFunction(a, b)
            print("This sample function simply prints out the result: \(result)")

            if result == a + b {
                expectation.fulfill()
            }
        }
        printMathResult(addTwoInts, 3, 5)

        // Block parameter without parenthesises
        waitForExpectationsWithTimeout(0.5, handler: { error in
            if let error = error {
                XCTFail("Something wrong with Math.addTwoInts function!")
            }
        })
    }
}
