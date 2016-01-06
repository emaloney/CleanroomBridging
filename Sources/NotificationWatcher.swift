//
//  NotificationWatcher.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 3/15/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

public class NotificationWatcher
{
    private let receiver: NotificationReceiver
    
    public init(notificationName: String, callback: (NSNotification) -> Void)
    {
        self.receiver = NotificationReceiver(notificationName: notificationName) { notif in
            callback(notif)
        }
    }
    
    public func stopWatching()
    {
        receiver.stopObserving()
    }
    
    public func resumeWatching()
    {
        receiver.startObserving()
    }
}

public class NotificationObjectWatcher<T>: NotificationWatcher
{
    public init(notificationName: String, callback: (NSNotification, T) -> Void)
    {
        super.init(notificationName: notificationName, callback: { notif in
            if let typedObj = notif.object as? T {
                callback(notif, typedObj)
            }
//            else {
//                Log.error?.message("Unexpected notification object type for \(notificationName)")
//            }
        })
    }
}

private class NotificationReceiver
{
    let callback: (NSNotification) -> Void
    let notificationName: String
    var isObserving = false
    
    init(notificationName: String, callback: (NSNotification) -> Void)
    {
        self.notificationName = notificationName
        self.callback = callback
        
        startObserving()
    }
    
    deinit {
        stopObserving()
    }
    
    @objc func notificationReceived(notification: NSNotification)
    {
        callback(notification)
    }
    
    func startObserving()
    {
        if !isObserving {
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("notificationReceived:"), name: notificationName, object: nil)
            isObserving = true
        }
    }
    
    func stopObserving()
    {
        if isObserving {
            isObserving = false
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
}
