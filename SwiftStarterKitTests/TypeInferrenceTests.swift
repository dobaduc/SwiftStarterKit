//
//  TypeInferrenceTests.swift
//  SwiftStarterKit
//
//  Created by Doba Duc on 7/8/15.
//  Copyright (c) 2015 Doba Duc. All rights reserved.
//

import XCTest
import Foundation

class TypeInferrenceTests: XCTestCase {
    func testInferrenceWithOneInheritanceLevel() {
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),
            Song(name: "Forever eternally", artist: "Steve Lee")
        ]

// NOTE: This experimental block of code extracts the precise inferred name of class item type
//        var arrayTypeString: String = "\(library.dynamicType)".componentsSeparatedByString(".").last!
//        let length = arrayTypeString.lengthOfBytesUsingEncoding(NSStringEncoding.allZeros)
//        let subStringIndex = advance(arrayTypeString.startIndex, length - 1)
//        arrayTypeString = arrayTypeString.substringToIndex(subStringIndex)
//        XCTAssert(arrayTypeString == "MediaItem", "Wrong type inferrence results")

        var arrayTypeString: String = "\(library.dynamicType)"
        XCTAssert(arrayTypeString == "Swift.Array<SwiftStarterKitTests.TypeInferrenceTests.MediaItem>", "Array item should be inferred to be `MediaItem`")

        var movieCount = 0, songCount = 0
        for item in library { // Each item now is a MediaItem
            // Downcast to use
            if item is Movie {
                ++movieCount
            } else if item is Song {
                ++songCount
            }
        }

        XCTAssert(movieCount == 2 && songCount == 3, "Something went wrong with Array item type")
    }

    func testInferrenceWithTwoInheritanceLevel() {
        let library = [
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),
            Song(name: "Forever eternally", artist: "Steve Lee"),
            JPopSong(name: "Forever eternally", artist: "Steve Lee")
        ]

        var arrayTypeString: String = "\(library.dynamicType)"
        XCTAssert(arrayTypeString == "Swift.Array<SwiftStarterKitTests.TypeInferrenceTests.Song>", "Array item should be inferred to be `Song`")
    }

}

extension TypeInferrenceTests {
    class MediaItem {
        var name: String
        init(name: String) {
            self.name = name
        }
    }

    class Movie: MediaItem {
        var director: String
        init(name: String, director: String) {
            self.director = director
            super.init(name: name)
        }
    }

    class Song: MediaItem {
        var artist: String
        init(name: String, artist: String) {
            self.artist = artist
            super.init(name: name)
        }
    }

    class JPopSong: Song { }
}