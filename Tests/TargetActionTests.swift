//
//  TargetActionTests.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 3/31/15.
//  Copyright (c) 2015 Gilt Groupe. All rights reserved.
//

import Foundation
import XCTest
import CleanroomBridging

class TargetActionTests: XCTestCase
{
    func testNoArgAction()
    {
        var flag = false
        let condition = NSCondition()

        let targetAction = TargetAction() {
            print("Invoked!")

            condition.lock()
            flag = true
            condition.signal()
            condition.unlock()
        }

        let timer = NSTimer(fireDate: NSDate.distantFuture(), interval: 0.0, target: targetAction.target, selector: targetAction.action, userInfo: nil, repeats: false)

        timer.fire()

        condition.lock()
        condition.waitUntilDate(NSDate().dateByAddingTimeInterval(1.0))
        condition.unlock()

        XCTAssertTrue(flag)
    }

    func testSingleArgAction()
    {
        var flag = false
        let condition = NSCondition()
        let userInfo = "(info for the user)"

        let targetAction = TargetAction() { (argument: AnyObject?) -> Void in
            print("Invoked with: \(argument?.description)")

            let timer = argument as? NSTimer
            XCTAssertTrue(timer != nil)
            XCTAssertTrue(timer!.userInfo as? String == userInfo)

            condition.lock()
            flag = true
            condition.signal()
            condition.unlock()
        }

        let timer = NSTimer(fireDate: NSDate.distantFuture(), interval: 0.0, target: targetAction.target, selector: targetAction.action, userInfo: userInfo, repeats: false)

        timer.fire()

        condition.lock()
        condition.waitUntilDate(NSDate().dateByAddingTimeInterval(1.0))
        condition.unlock()

        XCTAssertTrue(flag)
    }
}
