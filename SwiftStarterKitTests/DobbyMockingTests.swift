//
//  DobbyTests.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 7/3/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

// NOTE: This module is temporarily commented out because Dobby doesn't work after being imported as a framework

//import Quick
//import Nimble
//import Dobby
//
//struct MyMock {
//    let mock = Mock<String>()
//
//    func myMethod(input: String) -> String {
//        record(mock, input)
//        return input.uppercaseString
//    }
//}
//
//class MockSpec: QuickSpec {
//    override func spec() {
//        describe("Comparing two arguments for equality") {
//            context("when both are values") {
//                it("should compare the contained values for equality") {
//                    expect(value(1) == value(1)).to(beTrue())
//                    expect(value(1) == value(2)).to(beFalse())
//                }
//            }
//
//            context("when one is a value and one is a filter") {
//                it("should use the filter") {
//                    expect(value(1) == filter { (x: Int) in x == 1 }).to(beTrue())
//                    expect(filter { (x: Int) in x == 1 } == value(2)).to(beFalse())
//                }
//            }
//
//            context("when one matches anything") {
//                it("should always succeed") {
//                    expect(value(1) == any()).to(beTrue())
//                    expect(any() == value(1)).to(beTrue())
//                    expect(filter { (x: Int) in x == 1 } == any()).to(beTrue())
//                    expect(any() == filter { (x: Int) in x == 1 }).to(beTrue())
//                    expect(any() as Argument<Int> == any() as Argument<Int>).to(beTrue())
//                }
//            }
//
//            context("when both are filters") {
//                it("should always fail") {
//                    expect(filter { (x: Int) in x == 1 } == filter { (x: Int) in x == 1 }).to(beFalse())
//                }
//            }
//        }
//    }
//}
//
