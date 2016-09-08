//
//  NSTimerExtension.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 10/1/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

extension Timer
{
    public typealias TimerFiredCallback = (Timer) -> Void

    public class func scheduledTimerWithTimeInterval(_ interval: TimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, callback: @escaping TimerFiredCallback)
        -> Timer
    {
        let ta = TargetAction() { (obj: AnyObject?) in
            callback(obj as! Timer)
        }

        let timer = Timer(timeInterval: interval, target: ta, selector: ta.action, userInfo: userInfo, repeats: repeats)

        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)

        return timer
    }

    public class func scheduledTimerWithFireDate(_ fireDate: Date, callback: @escaping TimerFiredCallback)
        -> Timer
    {
        let timer = Timer(fireDate: fireDate, callback: callback)

        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)

        return timer
    }

    public class func scheduledTimerWithFireDate(_ fireDate: Date, repeatInterval: TimeInterval, callback: @escaping TimerFiredCallback)
        -> Timer
    {
        let timer = Timer(fireDate: fireDate, repeatInterval: repeatInterval, callback: callback)

        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)

        return timer
    }

    public convenience init(fireDate: Date, callback: @escaping TimerFiredCallback)
    {
        let ta = TargetAction() { (obj: AnyObject?) in
            callback(obj as! Timer)
        }

        self.init(fireAt: fireDate, interval: 0.0, target: ta, selector: ta.action, userInfo: nil, repeats: false)
    }

    public convenience init(fireDate: Date, repeatInterval: TimeInterval, callback: @escaping TimerFiredCallback)
    {
        let ta = TargetAction() { (obj: AnyObject?) in
            callback(obj as! Timer)
        }

        self.init(fireAt: fireDate, interval: repeatInterval, target: ta, selector: ta.action, userInfo: nil, repeats: true)
    }
}
