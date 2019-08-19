//
//  ContactAppTests.swift
//  ContactAppTests
//
//  Created by Pawan Kumar on 18/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import XCTest
@testable import ContactApp

class ContactAppTests: XCTestCase {
    var session: URLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        session = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        super.tearDown()
    }
    
    func testCallForGetCompleteListFromServer() {
        // given
        let url = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = session.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testCallForGettingContactDetails() {
        // given
        let contactId: Int = 5653
        let profileUrl = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts/\(contactId).json")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = session.dataTask(with: profileUrl!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testCallForAddNewContact() {
        // given
        let profileUrl = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json")
        let params: [String:String] = ["first_name": "Test", "last_name": "Case", "email": "test@case.com", "phone_number": "9812472183"]
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        var request = URLRequest(url: profileUrl!)
        
        request.timeoutInterval = 5.0
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        catch {
            XCTAssertEqual(0, 1, "given parameters are not correct")
        }
        
        // when
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 201)
    }
    
    func testCallForUpdateContact() {
        // given
        let contactId: Int = 5653
        let profileUrl = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts/\(contactId).json")
        
        let params: [String:String] = ["first_name": "After", "last_name": "Update", "email": "test@case.com", "phone_number": "1234567890"]
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        var request = URLRequest(url: profileUrl!)
        
        request.timeoutInterval = 5.0
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        catch {
            XCTAssertEqual(0, 1, "given parameters are not correct")
        }
        
        // when
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testCallForDeleteContact() {
        // given
        let contactId: Int = 6130
        let profileUrl = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts/\(contactId).json")
        
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        var request = URLRequest(url: profileUrl!)
        
        request.timeoutInterval = 5.0
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        // when
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        if statusCode == 404 {
            XCTAssertEqual(statusCode, 404, "Already deleted")
        }
        else {
            XCTAssertEqual(statusCode, 204, "Deleted")
        }
    }
}
