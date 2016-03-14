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
    
    public init(notificationName: String, object: AnyObject? = nil, startWatching: Bool = true, callback: (NSNotification) -> Void)
    {
        self.receiver = NotificationReceiver(notificationName: notificationName, object: object, startWatching: startWatching) { notif in
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
    public init(notificationName: String, object: AnyObject? = nil, startWatching: Bool = true, callback: (NSNotification, T) -> Void)
    {
        super.init(notificationName: notificationName, object: object, startWatching: startWatching, callback: { notif in
            if let typedObj = notif.object as? T {
                callback(notif, typedObj)
            }
        })
    }
}

private class NotificationReceiver
{
    let callback: (NSNotification) -> Void
    let notificationName: String
    let object: AnyObject?
    var isObserving = false
    
    init(notificationName: String, object: AnyObject? = nil, startWatching: Bool, callback: (NSNotification) -> Void)
    {
        self.notificationName = notificationName
        self.object = object
        self.callback = callback

        if startWatching {
            startObserving()
        }
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
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("notificationReceived:"), name: notificationName, object: object)
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
