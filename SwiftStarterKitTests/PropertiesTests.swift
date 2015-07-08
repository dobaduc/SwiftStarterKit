//
//  PropertiesTests.swift
//  TestFrameworkDemos-Swift
//
//  Created by Doba Duc on 7/2/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import XCTest

class PropertiesTests: XCTestCase {
    struct Logger {
        static var logContent = ""
        static func flush() {
            logContent = ""
        }
        static func log(string: String) {
            logContent += string
        }
    }

    class DataImporter {
        // Simplest form of store properties: variables and constants
        var file: String
        let folder: String

        init(file fileName: String?, folder folderPath: String?) {
            file = fileName ?? "default.dat"
            folder = folderPath ?? "/Users/me/Documents"

            Logger.log("DataImporter has been initialized")
        }
    }

    class DataManager {
        lazy var importer = DataImporter(file: nil, folder: nil)
        var data = [String]()

        func printImporterInfo() {
            print("Importer info: \(importer.file) \n")
        }
    }

    override func setUp() {
        Logger.flush()
    }

    func testDataManager() {
        let manager = DataManager()

        XCTAssertTrue(Logger.logContent == "", "Importer should NOT exist at this timing")

        manager.printImporterInfo()

        XCTAssertTrue(Logger.logContent == "DataImporter has been initialized", "Importer shoud exist at this timing")
    }
}
