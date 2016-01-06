//
//  NSTimerExtension.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 10/1/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

extension NSTimer
{
    public typealias TimerFiredCallback = (NSTimer) -> Void

    public class func scheduledTimerWithTimeInterval(interval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, callback: TimerFiredCallback)
        -> NSTimer
    {
        let ta = TargetAction() { (obj: AnyObject?) in
            callback(obj as! NSTimer)
        }

        let timer = NSTimer(timeInterval: interval, target: ta, selector: ta.action, userInfo: userInfo, repeats: repeats)

        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)

        return timer
    }

    public class func scheduledTimerWithFireDate(fireDate: NSDate, callback: TimerFiredCallback)
        -> NSTimer
    {
        let timer = NSTimer(fireDate: fireDate, callback: callback)

        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)

        return timer
    }

    public class func scheduledTimerWithFireDate(fireDate: NSDate, repeatInterval: NSTimeInterval, callback: TimerFiredCallback)
        -> NSTimer
    {
        let timer = NSTimer(fireDate: fireDate, repeatInterval: repeatInterval, callback: callback)

        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)

        return timer
    }

    public convenience init(fireDate: NSDate, callback: TimerFiredCallback)
    {
        let ta = TargetAction() { (obj: AnyObject?) in
            callback(obj as! NSTimer)
        }

        self.init(fireDate: fireDate, interval: 0.0, target: ta, selector: ta.action, userInfo: nil, repeats: false)
    }

    public convenience init(fireDate: NSDate, repeatInterval: NSTimeInterval, callback: TimerFiredCallback)
    {
        let ta = TargetAction() { (obj: AnyObject?) in
            callback(obj as! NSTimer)
        }

        self.init(fireDate: fireDate, interval: repeatInterval, target: ta, selector: ta.action, userInfo: nil, repeats: true)
    }
}
