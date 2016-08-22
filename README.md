![Gilt Tech logo](https://raw.githubusercontent.com/gilt/Cleanroom/master/Assets/gilt-tech-logo.png)

# CleanroomBridging

The CleanroomBridging framework contains utilities that help bridge the gap between Objective-C and Swift.

CleanroomBridging is part of [the Cleanroom Project](https://github.com/gilt/Cleanroom) from [Gilt Tech](http://tech.gilt.com).


### Swift compatibility

**Important:** This is the `swift2.3` branch. It uses **Swift 2.3** and **requires Xcode 8.0 beta 6** (or higher) to compile.

2 other branches are also available:

- The [`master`](https://github.com/emaloney/CleanroomBridging) branch uses **Swift 2.2**, requiring Xcode 7.3
- The [`swift3`](https://github.com/emaloney/CleanroomBridging/tree/swift3) branch uses **Swift 3.0**, requiring Xcode 8.0 beta 6


#### Current status

Branch|Build status
--------|------------------------
[`master`](https://github.com/emaloney/CleanroomBridging)|[![Build status: master branch](https://travis-ci.org/emaloney/CleanroomBridging.svg?branch=master)](https://travis-ci.org/emaloney/CleanroomBridging)
[`swift2.3`](https://github.com/emaloney/CleanroomBridging/tree/swift2.3)|[![Build status: swift2.3 branch](https://travis-ci.org/emaloney/CleanroomBridging.svg?branch=swift2.3)](https://travis-ci.org/emaloney/CleanroomBridging)
[`swift3`](https://github.com/emaloney/CleanroomBridging/tree/swift3)|[![Build status: swift3 branch](https://travis-ci.org/emaloney/CleanroomBridging.svg?branch=swift3)](https://travis-ci.org/emaloney/CleanroomBridging)


### License

CleanroomBridging is distributed under [the MIT license](/blob/master/LICENSE).

CleanroomBridging is provided for your use—free-of-charge—on an as-is basis. We make no guarantees, promises or apologies. *Caveat developer.*


### Adding CleanroomBridging to your project

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

You’ll need to [integrate CleanroomBridging into your project](https://github.com/emaloney/CleanroomBridging/blob/master/INTEGRATION.md) in order to use [the API](https://rawgit.com/emaloney/CleanroomBridging/master/Documentation/API/index.html) it provides. You can choose:

- [Manual integration](https://github.com/emaloney/CleanroomBridging/blob/master/INTEGRATION.md#manual-integration), wherein you embed CleanroomBridging’s Xcode project within your own, **_or_**
- [Using the Carthage dependency manager](https://github.com/emaloney/CleanroomBridging/blob/master/INTEGRATION.md#carthage-integration) to build a framework that you then embed in your application.

Once integrated, just add the following `import` statement to any Swift file where you want to use CleanroomBridging:

```swift
import CleanroomBridging
```

## Using CleanroomBridging

### TargetAction

The `TargetAction` class allows you to use a Swift closure wherever a standard Cocoa target (`id`) and action (`SEL`) pair can be used.

The closure can take zero or one arguments, as is typical with the target/action paradigm.

#### Example: A UIButton action

You can use a `TargetAction` instance to set up `UIButton` action handler in conjunction with the `addTarget(_:, action:, forControlEvents:)` function declared as part of the `UIControl` superclass of `UIButton`:

```swift
func addActionHandlerForButton(button: UIButton)
{
	let handler = TargetAction() { (argument: AnyObject?) -> Void in
		let button = argument as? UIButton
		println("Button tapped: \(button?.description)")
	}
	
	button.addTarget(handler.target, action: handler.action, forControlEvents: .TouchUpInside)
}
```

The function above sets up a handler that will print out information about `button` when it is tapped.

Note that the closure passed to the `TargetAction` constructor takes an argument. In the case of a `UIControl` target/action, the argument's value will be the control sending the action.

#### Example: An NSTimer action

```swift
let clock = TargetAction() {
	println("The time is now \(NSDate())")
}

let timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                                           target: clock.target, 
                                         selector: clock.action,
                                         userInfo: nil,
                                          repeats: true)
```

The example above sets up a timer that will result in the current time being printed to the console every second.



### API documentation

For detailed information on using CleanroomBridging, [API documentation](https://rawgit.com/emaloney/CleanroomBridging/master/Documentation/API/index.html) is available.


## About

The Cleanroom Project began as an experiment to re-imagine Gilt’s iOS codebase in a legacy-free, Swift-based incarnation.

Since then, we’ve expanded the Cleanroom Project to include multi-platform support. Much of our codebase now supports tvOS in addition to iOS, and our lower-level code is usable on macOS and watchOS as well.

Cleanroom Project code serves as the foundation of Gilt on TV, our tvOS app [featured by Apple during the launch of the new Apple TV](http://www.apple.com/apple-events/september-2015/). And as time goes on, we'll be replacing more and more of our existing Objective-C codebase with Cleanroom implementations.

In the meantime, we’ll be tracking the latest releases of Swift & Xcode, and [open-sourcing major portions of our codebase](https://github.com/gilt/Cleanroom#open-source-by-default) along the way.


### Contributing

CleanroomBridging is in active development, and we welcome your contributions.

If you’d like to contribute to this or any other Cleanroom Project repo, please read [the contribution guidelines](https://github.com/gilt/Cleanroom#contributing-to-the-cleanroom-project).


### Acknowledgements

[API documentation for CleanroomBridging](https://rawgit.com/emaloney/CleanroomBridging/master/Documentation/API/index.html) is generated using [Realm](http://realm.io)’s [jazzy](https://github.com/realm/jazzy/) project, maintained by [JP Simard](https://github.com/jpsim) and [Samuel E. Giddins](https://github.com/segiddins).

