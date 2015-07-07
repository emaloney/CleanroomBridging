![Gilt Tech logo](https://raw.githubusercontent.com/gilt/Cleanroom/master/Assets/gilt-tech-logo.png)

# CleanroomBridging

The CleanroomBridging framework contains utilities that help bridge the gap between Objective-C and Swift.

CleanroomBridging is part of [the Cleanroom Project](https://github.com/gilt/Cleanroom) from [Gilt Tech](http://tech.gilt.com).


### Swift 2.0 compatibility

The `master` branch of this project is Swift 2.0 compliant and therefore **requires Xcode 7 beta 2 or higher to compile**.


### License

CleanroomBridging is distributed under [the MIT license](/blob/master/LICENSE).

CleanroomBridging is provided for your use—free-of-charge—on an as-is basis. We make no guarantees, promises or apologies. *Caveat developer.*


### Adding CleanroomBridging to your project

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

You'll need to [integrate CleanroomBridging into your project](https://github.com/emaloney/CleanroomBridging/blob/master/INTEGRATION.md) in order to use [the API](https://rawgit.com/emaloney/CleanroomBridging/master/Documentation/index.html) it provides. You can choose:

- [Manual integration](https://github.com/emaloney/CleanroomBridging/blob/master/INTEGRATION.md#manual-integration), wherein you embed CleanroomBridging's Xcode project within your own, **_or_**
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

For detailed information on using CleanroomBridging, [API documentation](https://rawgit.com/emaloney/CleanroomBridging/master/Documentation/index.html) is available.


## About

The Cleanroom Project is an experiment in re-imagining Gilt's iOS codebase in a legacy-free incarnation that embraces the latest Apple technology.

We'll be tracking the most up-to-date releases of Swift, iOS and Xcode, and we'll be [open-sourcing major portions of our code](https://github.com/gilt/Cleanroom#open-source-by-default) as we go.


### Contributing

CleanroomBridging is in active development, and we welcome your contributions.

If you’d like to contribute to this or any other Cleanroom Project repo, please read [the contribution guidelines](https://github.com/gilt/Cleanroom#contributing-to-the-cleanroom-project).


### Acknowledgements

[API documentation for CleanroomBridging](https://rawgit.com/emaloney/CleanroomBridging/master/Documentation/index.html) is generated using [Realm](http://realm.io)'s [jazzy](https://github.com/realm/jazzy/) project, maintained by [JP Simard](https://github.com/jpsim) and [Samuel E. Giddins](https://github.com/segiddins).

