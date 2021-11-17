//
//  PhotoLoaderTests.swift
//  PhotoLoaderTests
//
//  Created by Alexander v. Below on 17.11.21.
//

import XCTest
@testable import PhotoLoader

class PhotoLoaderTests: XCTestCase {

    func testPhotoInfo() throws {

        let inputString = """
[
{
"id": "0",
"author": "Alejandro Escamilla",
"width": 5616,
"height": 3744,
"url": "https://unsplash.com/photos/yC-Yzbqy7PY", "download_url": "https://picsum.photos/id/0/5616/3744"
},
]
"""
        let inputData = inputString.data(using: .utf8)!

        var result: [PhotoInfo]!
        XCTAssertNoThrow (
            result = try JSONDecoder().decode([PhotoInfo].self, from: inputData)
        )
        XCTAssert(result.count > 0)
        let element = result.first!
        XCTAssertEqual(element.id, "0")
        XCTAssertEqual(element.author, "Alejandro Escamilla")
        XCTAssertEqual(element.width, 5616)
        XCTAssertEqual(element.height, 3744)
        XCTAssertEqual(element.url, "https://unsplash.com/photos/yC-Yzbqy7PY")
        XCTAssertEqual(element.download_url, "https://picsum.photos/id/0/5616/3744")
    }
}
