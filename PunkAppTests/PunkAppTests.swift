//
//  PunkAppTests.swift
//  PunkAppTests
//
//  Created by Bryan Caro on 5/25/21.
//

import XCTest
@testable import PunkApp

class PunkAppTests: XCTestCase {
    var sut: URLSession!
    let networkMonitor = BeerService?.self
    
    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
      

      // given
      let urlString = "https://api.punkapi.com/v2/beers?page=1&per_page=20"
      let url = URL(string: urlString)!
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let dataTask = sut.dataTask(with: url) { _, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

/*
 @testable import PunkApp

 class PunkAppUITests: XCTestCase {
     var sut: BeerService!
     override func setUpWithError() throws {
         try super.setUpWithError()
         sut = BeerService()
     }

     override func tearDownWithError() throws {
         sut = nil
         try super.tearDownWithError()
     }
 */
