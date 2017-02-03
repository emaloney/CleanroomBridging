//
//  TargetActionTests.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 3/31/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
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

        let timer = Timer(fireAt: Date.distantFuture, interval: 0.0, target: targetAction.target, selector: targetAction.action, userInfo: nil, repeats: false)

        timer.fire()

        condition.lock()
        condition.wait(until: Date().addingTimeInterval(1.0))
        condition.unlock()

        XCTAssertTrue(flag)
    }

    func testSingleArgAction()
    {
        var flag = false
        let condition = NSCondition()
        let userInfo = "(info for the user)"

        let targetAction = TargetAction() { (argument: Any?) -> Void in
            print("Invoked with: \(argument)")

            let timer = argument as? Timer
            XCTAssertTrue(timer != nil)
            XCTAssertTrue(timer!.userInfo as? String == userInfo)

            condition.lock()
            flag = true
            condition.signal()
            condition.unlock()
        }

        let timer = Timer(fireAt: Date.distantFuture, interval: 0.0, target: targetAction.target, selector: targetAction.action, userInfo: userInfo, repeats: false)

        timer.fire()

        condition.lock()
        condition.wait(until: Date().addingTimeInterval(1.0))
        condition.unlock()

        XCTAssertTrue(flag)
    }
}
