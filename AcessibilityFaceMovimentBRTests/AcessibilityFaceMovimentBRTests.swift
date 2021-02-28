//
//  AcessibilityFaceMovimentBRTests.swift
//  AcessibilityFaceMovimentBRTests
//
//  Created by Joao Batista on 04/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import XCTest
@testable import AcessibilityFaceMovimentBR

class AcessibilityFaceMovimentBRTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
      let teste = FaceSensitivity(limitedTopX: 0.4, limitedBottonX: -0.6, limitedTopY: -0.8, limitedBottonY: 0.8)

      XCTAssertEqual(teste.getLimitedX(), 1.0)
      XCTAssertEqual(teste.getLimitedY(), 1.6)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
