//
//  OtherSwiftSyntaxTests.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 7/7/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//
import XCTest

class OtherSwiftSyntaxTests: XCTestCase {

    func testSomeMoreSwiftSyntax() {
        // NOTE: # has been removed from Swift 2.0
        func containsCharacter(#string: String, #characterToFind: Character) -> Bool {
            for character in string {
                if character == characterToFind {
                    return true
                }
            }
            return false
        }

        // Variadic Parameters
        func min(numbers: Int...) -> Int {
            var min: Int = Int.max
            for number in numbers {
                if min > number {
                    min = number
                }
            }
            return min
        }

        XCTAssert(min(10, 4, 332, 232, 2, 11, 1) == 1, "Min should be 1")
    }

    // MARK:- Literal
    func testNumberLiteralWithUnderscore() {
        let creditCardNumber = 1234_5678_9012
        let phoneNumber = 0120_1234_5678 // phoneNumber == 12012345678
        let phoneNumberString: String = "" + 0120_1234_5678.description // phoneNumberString == "12012345678"
        let numberFromString = "1234_4567_4343".toInt() // ---> numberFromString == nil

        XCTAssert(creditCardNumber == 123456789012 , "Failed")
        XCTAssert(phoneNumber == 12012345678 , "Failed")
        XCTAssert(phoneNumberString == "12012345678" , "Failed")
        XCTAssertNil(numberFromString , "Failed")
    }

    // MARK:- Others
    func testSwiftForFun() {
//        func sum(a: Int)(b: Int){
//            return (b: Int)
//        }

    }
}
