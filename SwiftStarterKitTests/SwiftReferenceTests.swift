//
//  SwiftReferenceTests.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 7/1/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import XCTest


// Refer to the example in Swift's official document at:
// https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID48


// MARK:- unown reference test 1
class SwiftReferenceTests: XCTestCase {
    struct Logger {
        static var log = ""
    }

    class Parent {
        var child: Child?

        deinit {
            Logger.log += "Parent_Deinited "
        }
    }

    class Child {
        // This "guarantees" that child always has a non-nil Parent
        // Hereby both 'let' or 'var' have the same effect
        unowned var parent: Parent

        init(parent: Parent) {
            self.parent = parent
        }

        func introduceParent() {
            print("My parent is \(parent)")
        }

        deinit {
            Logger.log += "Child_Deinited "
        }
    }

    override func setUp() {
        Logger.log = ""
    }

    func testDestroyableUnownedReference() {
        var parent: Parent? = Parent()
        parent!.child = Child(parent: parent!)

        parent = nil // This will kill both parent and child because retain count of Child instance becomes 0
        XCTAssert(Logger.log == "Parent_Deinited Child_Deinited ", "Both parent and child should be destroyed")
    }

    func testExceptionOnUnownedReference() {
        var parent: Parent? = Parent()
        var child = Child(parent: parent!)

        parent = nil // This will kill parent

        // This call will cause an exception, because it try to access a nil parent reference
        //child.introduceParent()
    }
}