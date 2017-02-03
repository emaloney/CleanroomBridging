//
//  AssociatedObjectTests.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 8/30/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

import XCTest
import Foundation
import CleanroomBridging

class AssociatedObjectTests: XCTestCase
{
    func testAssociatedObject()
    {
        let receiver = NSObject()
        let key = "old timey key"
        let fineMess = "This is a fine mess"
        receiver.setAssociated(fineMess, forKey: key, storagePolicy: .retainAtomic)
        let gotten = receiver.associatedObject(forKey: key)
        XCTAssertEqual(gotten as? String, fineMess)
    }

    func testAssociatedObjectWithoutCommonKeyConstant()
    {
        // this fails sporadically under CleanroomBridging 0.7.0 and lower
        let receiver = NSObject()
        let fineMess = "This is a fine mess"
        receiver.setAssociated(fineMess, forKey: "old timey key", storagePolicy: .retainAtomic)
        let gotten = receiver.associatedObject(forKey: "old timey key")
        XCTAssertEqual(gotten as? String, fineMess)
    }

    func testAssociatedObjectWithDifferentKeyInstance()
    {
        // this fails 100% of the time under CleanroomBridging 0.7.0 and lower
        let receiver = NSObject()
        let fineMess = "This is a fine mess"
        receiver.setAssociated(fineMess, forKey: ("old timey key" as NSString).copy() as! String, storagePolicy: .retainAtomic)
        let gotten = receiver.associatedObject(forKey: ("old timey key" as NSString).copy() as! String)
        XCTAssertEqual(gotten as? String, fineMess)
    }
}
