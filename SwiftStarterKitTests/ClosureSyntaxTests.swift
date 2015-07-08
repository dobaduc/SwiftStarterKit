//
//  ClosureSyntaxTests.swift
//  TestFrameworkDemos-SwiftTests
//
//  Created by Doba Duc on 6/29/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import XCTest


class ClosureSyntaxTests: XCTestCase {

    func testClosureWithParameterNamesAndReturnType() {
        var strings = ["25", "11", "3333"]
        sort(&strings, { (s1: String, s2: String) -> Bool in
            return s1 < s2
        })

        XCTAssert(strings[0] == "11" && strings[1] == "25" && strings[2] == "3333", "Array sorting went wrong")
    }

    func testClosureWithoutParameterNamesAndReturnType() {
        var strings = ["25", "11", "3333"]
        sort(&strings, { s1, s2 in
            s1 > s2
        })

        XCTAssert(strings[0] == "3333" && strings[1] == "25" && strings[2] == "11", "Array sorting went wrong")
    }

    func testClosureWithShorthandParameters() {
        var strings = ["25", "11", "3333"]
        sort(&strings, { $0 > $1 })

        XCTAssert(strings[0] == "3333" && strings[1] == "25" && strings[2] == "11", "Array sorting went wrong")
    }

    func testClosureWithOperatorFunction() {
        var strings = ["25", "11", "3333"]
        sort(&strings, (>))

        XCTAssert(strings[0] == "3333" && strings[1] == "25" && strings[2] == "11", "Array sorting went wrong")
    }

    func testClosureWithoutReturnType() {
        let sum = {(left: Int, right: Int) in
            return left + right
        }
        XCTAssert(sum(10, 5) == 15,  "10 + 5 should be 15!")
    }

    func testInoutParameters() {
        var leftValue = 3
        var rightValue = 4
        
        func swapValues(inout left: Int, inout right: Int) {
            let temporaryValue = left
            left = right
            right = temporaryValue
        }
        swapValues(&leftValue, &rightValue)

        XCTAssert(leftValue == 4 && rightValue == 3,  "Left value should be 4, right value should be 3!")
    }

    func testInlineClosure() {
        let numbers: [Int] = [5, 10, 100, 15, 20, 60]
        // NOTE: let n = 5 -1 will generate compile error

        let sumOfFirstHalf: Int = {
            var total: Int = 0
            for i in 0 ..< numbers.count / 2 {
                total += numbers[i]
            }
            return total
        }()

        let sumOfTheRest: Int = {
            var total: Int = 0
            for i in numbers.count / 2 ..< numbers.count {
                total += numbers[i]
            }
            return total
        }()

        XCTAssert(sumOfFirstHalf == 115 && sumOfTheRest == 95,  "Calculation went wrong!")
    }

    func testTrailingClosure() {
        let numbers: [Int] = [5, 10, 100, 15, 20, 60]
        let expectation = self.expectationWithDescription("Completion block must be invoked")

        func sum(array: [Int], completionBock: (totalValue: Int) -> Void) {
            var total = 0
            for number in array {
                total += number
            }
            completionBock(totalValue: total)
        }

        sum(numbers, { (totalValue) -> Void in
            print(totalValue)
            expectation.fulfill()
        })

        // NOTE: This is actually a good example of trailing closure
        waitForExpectationsWithTimeout(2) {(error) -> Void in
            if let error = error {
                XCTFail("Something went wrong")
            }
        }
    }

    func testTrailingClosureHavingNoParameters() {
        let numbers: [Int] = [5, 10, 100, 15, 20, 60]
        let expectation = self.expectationWithDescription("Dummy completion block must be invoked")

        func sum(array: [Int], completionBock: () -> Void) {
            var total = 0
            for number in array {
                total += number
            }
            completionBock()
        }

        sum(numbers, {
            expectation.fulfill()
        })

        waitForExpectationsWithTimeout(2) {(error) -> Void in
            if let error = error {
                XCTFail("Something went wrong")
            }
        }
    }
}
