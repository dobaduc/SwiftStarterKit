//
//  ServerConnection.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 6/30/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import Foundation

// NOTE: Removing Connection protocol will definitely cause a runtime error at fetchDataFromAPI() method
// This may be potentially an issue
@objc protocol Connection {
    func fetchDataFromAPI() -> String
}

class ServerConnection : NSObject, Connection {
    func fetchDataFromAPI() -> String {
        return "Real data returned from API"
    }
}

@objc class DummyController {
    // NOTE: Using ServerConnection will cause a realtime error
    // var connection: ServerConnection
    var connection: Connection

    var data: String

    class func newController(connection: ServerConnection) -> DummyController {
        return DummyController(connection: connection)
    }

    init(connection: ServerConnection) {
        self.connection = connection
        data = ""
    }

    func fetchData() {
        data = connection.fetchDataFromAPI()
    }
}

