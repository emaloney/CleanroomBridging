//
//  TargetAction.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 3/31/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

/**
 The `TargetAction` class bridges the gap between Swift closures and the common
 Cocoa target (`id`)/action (`SEL`) paradigm. Construct a `TargetAction` with
 a no-argument or single-argument callback closure. Then, use the `target` and
 `action` properties of the `TargetAction` instance as you would normally
 anywhere Cocoa calls for a target/action.
 */
open class TargetAction
{
    /** The object to use as the *target* of a target/action pair. */
    open var target: Any { return self }

    /** The `Selector` to use as the *action* of the target/action pair. */
    open var action: Selector {
        get {
            if noArgCallback != nil {
                return #selector(TargetAction.noArgAction)
            } else {
                return #selector(TargetAction.singleArgAction(_:))
            }
        }
    }

    private let noArgCallback: (() -> Void)?
    private let singleArgCallback: ((Any?) -> Void)?

    /**
     Constructs a `TargetAction` with a no-argument callback.

     - parameter callback: A callback closure that will be executed when the 
     target/action pair represented by the newly-constructed instance is
     invoked.
    */
    public init(callback: @escaping () -> Void)
    {
        self.noArgCallback = callback
        self.singleArgCallback = nil
    }

    /**
     Constructs a `TargetAction` with a single-argument callback.

     - parameter callback: A callback closure that will be executed when the 
     target/action pair represented by the newly-constructed instance is
     invoked. The `Any?` argument passed to `callback` will be the 
     argument sent to `action` when invoked.
    */
    public init(callback: @escaping (Any?) -> Void)
    {
        self.noArgCallback = nil
        self.singleArgCallback = callback
    }

    @objc private func noArgAction()
    {
        noArgCallback!()
    }

    @objc private func singleArgAction(_ arg: Any?)
    {
        singleArgCallback!(arg)
    }
}
