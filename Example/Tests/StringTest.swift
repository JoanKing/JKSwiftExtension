//
//  StringTest.swift
//  JKSwiftExtension_Tests
//
//  Created by IronMan on 2020/9/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import JKSwiftExtension
class StringTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        // test1()

        test2()
    }
    
    func test2() {
        let studentsName = "我是一只小小鸟A"
        // 判断是不是 nil
        XCTAssertTrue(studentsName.containsIgnoringCase(find: "a"), "包含字符串")
    }
    
    func test1() {
        let studentsName = "我是一只小小鸟"
        // 判断是不是 nil
        XCTAssertNotNil(studentsName.range(of: "小"), "包含字符串")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
