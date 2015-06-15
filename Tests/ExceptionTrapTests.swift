//
//  ExceptionTests.swift
//  Cleanroom
//
//  Created by Evan Maloney on 1/2/15.
//  Copyright (c) 2015 Gilt Groupe. All rights reserved.
//

import XCTest
import CleanroomBridging

class ExceptionTests: XCTestCase
{
    func testTry()
    {
        let shouldSucceed = Exception.doTry {
            // some inocuous code that shouldn't throw an exception
            let constant = 50
            let halfOfConstant = constant / 2
            XCTAssertEqual(halfOfConstant, 25)
        }
        XCTAssert(shouldSucceed)

        let shouldFail = Exception.doTry({
            // throwing an exception should result in returning false
            Exception.throwExceptionWithName("It's full of fail!")
        })
        XCTAssertFalse(shouldFail)
    }

    func testTryCatch()
    {
        var didHitCatchBlock = false
        let shouldSucceed = Exception
            .doTry({
                // some inocuous code that shouldn't throw an exception
                let constant = 50
                let halfOfConstant = constant / 2
                XCTAssertEqual(halfOfConstant, 25)
            },
            catchException: {ex in
                print("Unexpected exception caught: \(ex))")
                didHitCatchBlock = true
            }
        )
        XCTAssert(shouldSucceed)
        XCTAssertFalse(didHitCatchBlock)

        let shouldFail = Exception
            .doTry({
                // throwing an exception should result in 
                // hitting the catch block below & returning false
                Exception.throwExceptionWithName("It's full of fail!", reason: "I have my reasons.")
            },
            catchException: {ex in
                print("Exception caught (this was an expected failure and is safe to ignore): \(ex))")
                didHitCatchBlock = true
            }
        )
        XCTAssertFalse(shouldFail)
        XCTAssert(didHitCatchBlock)
    }

    func testTryFinally()
    {
        var didHitFinallyBlock = false
        let shouldSucceed = Exception
            .doTry({
                // some inocuous code that shouldn't throw an exception
                let constant = 50
                let halfOfConstant = constant / 2
                XCTAssertEqual(halfOfConstant, 25)
            },
            finally: {
                didHitFinallyBlock = true
            }
        )
        XCTAssert(shouldSucceed)
        XCTAssert(didHitFinallyBlock)

        didHitFinallyBlock = false          // reset this variable
        let shouldFail = Exception
            .doTry({
                // throwing an exception should result in
                // hitting the catch block below & returning false
                Exception.throwExceptionWithName("It's full of fail!", reason: "I have my reasons.", userInfo: ["info": "here is some info"])
            },
            finally: {
                didHitFinallyBlock = true
            }
        )
        XCTAssertFalse(shouldFail)
        XCTAssert(didHitFinallyBlock)
    }

    func testTryCatchFinally()
    {
        var didHitCatchBlock = false
        var didHitFinallyBlock = false
        let shouldSucceed = Exception
            .doTry({
                // some inocuous code that shouldn't throw an exception
                let constant = 50
                let halfOfConstant = constant / 2
                XCTAssertEqual(halfOfConstant, 25)
            },
            catchException: {ex in
                print("Unexpected exception caught: \(ex))")
                didHitCatchBlock = true
            },
            finally: {
                didHitFinallyBlock = true
            }
        )
        XCTAssert(shouldSucceed)
        XCTAssertFalse(didHitCatchBlock)
        XCTAssert(didHitFinallyBlock)

        didHitFinallyBlock = false          // reset this variable
        let shouldFail = Exception
            .doTry({
                // throwing an exception should result in
                // hitting the catch block below & returning false
                Exception.throwExceptionWithName("It's full of fail!", reason: "I have my reasons.", userInfo: ["info": "different info than before"])
            },
            catchException: {ex in
                print("Exception caught (this was an expected failure and is safe to ignore): \(ex))")
                XCTAssertNotNil(ex.reason)
                XCTAssertEqual(ex.reason!, "I have my reasons.")
                XCTAssertNotNil(ex.userInfo)
                XCTAssertNotNil(ex.userInfo!["info"])
                XCTAssertNotNil(ex.userInfo!["info"] as? String)
                XCTAssertEqual(ex.userInfo!["info"] as! String, "different info than before")
                didHitCatchBlock = true
            },
            finally: {
                didHitFinallyBlock = true
            }
        )
        XCTAssertFalse(shouldFail)
        XCTAssert(didHitCatchBlock)
        XCTAssert(didHitFinallyBlock)
    }
}

