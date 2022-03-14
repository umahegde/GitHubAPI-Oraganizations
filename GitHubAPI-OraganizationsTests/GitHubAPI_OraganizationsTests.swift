//
//  GitHubAPI_OraganizationsTests.swift
//  GitHubAPI-OraganizationsTests
//
//  Created by Uma Hegde on 12/03/22.
//

import XCTest
@testable import GitHubAPI_Oraganizations

class GitHubAPI_OraganizationsTests: XCTestCase {

    var testSession: URLSession!
    var orgDetail: Organization!
    let networkMonitor = NetworkMonitor.shared


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testSession = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testSession = nil
    }


    
    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
      try XCTSkipUnless(
        networkMonitor.isReachable,
        "Network connectivity needed for this test.")

      // given
      let urlString = "https://api.github.com/organizations"
      let url = URL(string: urlString)!
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let dataTask = testSession.dataTask(with: url) { data, response, error in
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
    
    // Asynchronous test: faster fail
    func testApiCallCompletes() throws {
      try XCTSkipUnless(
        networkMonitor.isReachable,
        "Network connectivity needed for this test."
      )

      // given
      let urlString = "https://api.github.com/organizations"
      let url = URL(string: urlString)!
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = testSession.dataTask(with: url) { _, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
 

    // Asynchronous test: faster fail
    
    func testValidAPICallToReturnsValidResponse() throws {
      try XCTSkipUnless(
        networkMonitor.isReachable,
        "Network connectivity needed for this test.")

      // given
      let urlString = "https://api.github.com/organizations"
      let url = URL(string: urlString)!
      // 1
      let promise = expectation(description: "ValidRequest_Returns_ValidResponse")

      // when
      let dataTask = testSession.dataTask(with: url) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
              let organizationDetails = try? JSONDecoder().decode(Organizations.self, from: data!)
              
              guard let details = organizationDetails  else {
                  XCTFail("Data is empty")
                  return
              }
              self.orgDetail = details.first
              
              //   ASSERT
              XCTAssertEqual(statusCode, 200)
              XCTAssertNotNil(self.orgDetail)
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
    
 

}
