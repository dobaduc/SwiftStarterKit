//
//  OperatorFunctionTests.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 7/1/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import XCTest

class OperatorFunctionTests: XCTestCase {

    func testInfixOperator() {
        let order1 = Order(subtotal: 1000)
        let order2 = Order(subtotal: 2000)

        XCTAssert((order1 + order2).tax() == 240, "Tax calculation is wrong! Must be 240")
    }

    func testCompoundAssignmentOperator() {
        var order = Order(subtotal: 1000)
        order += Order(subtotal: 2000)

        XCTAssert(order.total == 3240, "Total amount calculation is wrong! Must be 3240")
    }
}


// MARK:- Necessary structs / methods for testing
struct Order {
    var subtotal: Int
    let taxRate: Float = 0.08

    // Play with a computed property
    var total: Int {
        return subtotal + tax()
    }

    // Keep tax as a func for demo purpose
    func tax() -> Int {
        return (Int)(Float(subtotal) * taxRate)
    }
}

// Operator function must be declared at file scope.
// Bringing this into class/ extensio cope will generate a compile error
// NOTE: read more about this: infix operator + { associativity left }
func + (order: Order, anotherOrder: Order) -> Order {
    return Order(subtotal: order.subtotal + anotherOrder.subtotal)
}

// Compound Assignment Operator
func += (inout order: Order, anotherOrder: Order) {
    order = order + anotherOrder
}
