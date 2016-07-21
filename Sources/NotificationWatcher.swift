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
    
    public init(notificationName: String, object: AnyObject? = nil, startWatching: Bool = true, callback: (Notification) -> Void)
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
    public init(notificationName: String, object: AnyObject? = nil, startWatching: Bool = true, callback: (Notification, T) -> Void)
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
    let callback: (Notification) -> Void
    let notificationName: String
    let object: AnyObject?
    var isObserving = false
    
    init(notificationName: String, object: AnyObject? = nil, startWatching: Bool, callback: (Notification) -> Void)
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
    
    @objc func notificationReceived(_ notification: Notification)
    {
        callback(notification)
    }
    
    func startObserving()
    {
        if !isObserving {
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationReceiver.notificationReceived(_:)), name: NSNotification.Name(rawValue: notificationName), object: object)
            isObserving = true
        }
    }
    
    func stopObserving()
    {
        if isObserving {
            isObserving = false
            NotificationCenter.default.removeObserver(self)
        }
    }
}
