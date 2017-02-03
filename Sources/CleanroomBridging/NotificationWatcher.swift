//
//  NotificationWatcher.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 3/15/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

open class NotificationWatcher
{
    private let receivers: [NotificationReceiver]

    public convenience init(notificationName: String, object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification) -> Void)
    {
        self.init(notification: Notification.Name(notificationName), object: object, startWatching: startWatching, callback: callback)
    }


    public convenience init(notificationNames: [String], object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification) -> Void)
    {
        let notifications = notificationNames.map { Notification.Name($0) }
        self.init(notifications: notifications, object: object, startWatching: startWatching, callback: callback)
    }

    public init(notification: Notification.Name, object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification) -> Void)
    {
        self.receivers = [NotificationReceiver(notification: notification, object: object, startWatching: startWatching, callback: callback)]
    }

    public init(notifications: [Notification.Name], object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification) -> Void)
    {
        self.receivers = notifications.map {
            return NotificationReceiver(notification: $0, object: object, startWatching: startWatching, callback: callback)
        }
    }

    open func stopWatching()
    {
        receivers.forEach { $0.stopObserving() }
    }
    
    open func resumeWatching()
    {
        receivers.forEach { $0.startObserving() }
    }
}

open class NotificationObjectWatcher<T>: NotificationWatcher
{
    public convenience init(notificationName: String, object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification, T) -> Void)
    {
        self.init(notification: Notification.Name(notificationName), object: object, startWatching: startWatching, callback: callback)
    }

    public convenience init(notificationNames: [String], object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification, T) -> Void)
    {
        let notifications = notificationNames.map { Notification.Name($0) }
        self.init(notifications: notifications, object: object, startWatching: startWatching, callback: callback)
    }

    public init(notification: Notification.Name, object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification, T) -> Void)
    {
        super.init(notification: notification, object: object, startWatching: startWatching, callback: { notif in
            if let typedObj = notif.object as? T {
                callback(notif, typedObj)
            }
        })
    }

    public init(notifications: [Notification.Name], object: Any? = nil, startWatching: Bool = true, callback: @escaping (Notification, T) -> Void)
    {
        super.init(notifications: notifications, object: object, startWatching: startWatching, callback: { notif in
            if let typedObj = notif.object as? T {
                callback(notif, typedObj)
            }
        })
    }
}

private class NotificationReceiver
{
    let callback: (Notification) -> Void
    let notification: Notification.Name
    let object: Any?
    var isObserving = false
    
    init(notification: Notification.Name, object: Any? = nil, startWatching: Bool, callback: @escaping (Notification) -> Void)
    {
        self.notification = notification
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
            NotificationCenter.default.addObserver(self, selector: #selector(NotificationReceiver.notificationReceived(_:)), name: notification, object: object)
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
