//
//  HRTimeTests.swift
//  HRTimeTests
//
//  Created by Evan Lucas on 12/28/15.
//  Copyright © 2015 Evan Lucas. All rights reserved.
//

import XCTest
@testable import HRTime

class HRTimeTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testHrtime() {
    let time = hrtime()
    let time2 = hrtime(time)
    XCTAssertLessThan(time2, 1500) // shouldn't be off by more than 1.5 ms
  }
  
  func testHrtimeDuration() {
    let time = hrtime()
    let timer = dispatch_time(DISPATCH_TIME_NOW, 1000 * Int64(NSEC_PER_MSEC))
    let exp = expectationWithDescription("hrtime")
    
    dispatch_after(timer, dispatch_get_main_queue(), {
      let time2 = hrtime(time)
      let res = time2 / 1000000
      XCTAssertLessThan(res, 1500) // shouldn't be off by more than 1.5 ms
      exp.fulfill()
    })
    
    waitForExpectationsWithTimeout(NSTimeInterval(1000), handler: { (error) in
      if let error = error {
        print("Error: \(error)")
      }
    })
  }
  
  func testHrtimePerf() {
    self.measureBlock {
      let time = hrtime()
      _ = hrtime(time)
    }
  }
}
