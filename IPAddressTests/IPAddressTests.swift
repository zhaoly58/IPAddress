////
////  IPAddressTests.swift
////  IPAddressTests
////
////  Created by Jimmy Zhao on 2024/05/08.
////
//
//import XCTest
//@testable import IPAddress
//
//final class IPAddressTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

//
//  MVVMUserViewModelTests.swift
//  IPAddressTests
//
//  Created by Jimmy Zhao on 2025/5/24.
//

import XCTest
import Combine
@testable import IPAddress

final class MVVMUserViewModelTests: XCTestCase {
    
    var viewModel: MVVMUserViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = MVVMUserViewModel()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialUserNameIsJimmy () {
        XCTAssertEqual(viewModel.user.name, "Jimmy", "The inital username should be Jimmy")
    }
    
    func testChangingUserName() {
        let initialName = viewModel.user.name
        viewModel.changeName()
        let newName = viewModel.user.name
        XCTAssertNotEqual(initialName, newName, "The username should be different after changing")
        XCTAssertTrue(newName.hasPrefix("Jimmy"), "The new name should also be started with 'Jimmy'")
    }

    func testPublishedUserIsUpdated() {
        let expectation = XCTestExpectation(description: "User name should be updated")
        
        viewModel.$user
            .dropFirst()
            .sink { user in
                XCTAssertTrue(user.name.hasPrefix("Jimmy"))
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.changeName()
        
        wait(for: [expectation], timeout: 1)
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
