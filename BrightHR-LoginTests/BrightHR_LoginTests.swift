//
//  BrightHR_LoginTests.swift
//  BrightHR-LoginTests
//
//  Created by Joshua Colley on 09/11/2017.
//  Copyright © 2017 Joshua Colley. All rights reserved.
//

import XCTest
@testable import BrightHR_Login

class BrightHR_LoginTests: XCTestCase {
    
    let viewController:LoginVC = LoginVC()
    
    
    
    
    func testDataRequest() {
        let url = URL(string: "http://joshcolley.com")!
        
        XCTAssertNil(self.viewController.dataRequest(url))
    }
    
}
