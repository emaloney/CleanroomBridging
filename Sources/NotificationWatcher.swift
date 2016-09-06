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
    private let receivers: [NotificationReceiver]

    public init(notificationName: String, object: AnyObject? = nil, startWatching: Bool = true, callback: @escaping (Notification) -> Void)
    {
        self.receivers = [NotificationReceiver(notificationName: notificationName, object: object, startWatching: startWatching) { notif in
            callback(notif)
        }]
    }

    public init(notificationNames: [String], object: AnyObject? = nil, startWatching: Bool = true, callback: @escaping (Notification) -> Void)
    {
        self.receivers = notificationNames.map {
            return NotificationReceiver(notificationName: $0, object: object, startWatching: startWatching) { notif in
                callback(notif)
            }
        }
    }

    public func stopWatching()
    {
        receivers.forEach{ $0.stopObserving() }
    }
    
    public func resumeWatching()
    {
        receivers.forEach{ $0.startObserving() }
    }
}

public class NotificationObjectWatcher<T>: NotificationWatcher
{
    public init(notificationName: String, object: AnyObject? = nil, startWatching: Bool = true, callback: @escaping (Notification, T) -> Void)
    {
        super.init(notificationName: notificationName, object: object, startWatching: startWatching, callback: { notif in
            if let typedObj = notif.object as? T {
                callback(notif, typedObj)
            }
        })
    }

    public init(notificationNames: [String], object: AnyObject? = nil, startWatching: Bool = true, callback: @escaping (Notification, T) -> Void)
    {
        super.init(notificationNames: notificationNames, object: object, startWatching: startWatching, callback: { notif in
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
    
    init(notificationName: String, object: AnyObject? = nil, startWatching: Bool, callback: @escaping (Notification) -> Void)
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
