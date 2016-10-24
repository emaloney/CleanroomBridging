//
//  NotificationPostingExtension.swift
//  CleanroomBridging
//
//  Created by Evan Maloney on 4/12/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

import Foundation

extension Notification
{
    public static func post(_ notification: Notification.Name, object: Any? = nil)
    {
        NotificationCenter.default.post(name: notification, object: object)
    }
}
