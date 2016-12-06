# Logger [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

⚠️ Logger is new-as-can-be and lots of stuff is missing. Feel free to
[contribute][CONTRIBUTING].

Logger is a library that gives you a uniform interface for logging and lets you
add any number of handlers (which is loggers name for *output streams*) that
catches what you log and does something with it. Built in is the `PrintHandler`
which simply `print()`s the logs, but it's would be easy to add a Sentry-handler
that sends all logs off to Sentry, or an Alert-handler that creates
`UIAlertController`s for all logs with level `.verbose`.

## Usage tl;dr:

Setting up the built-in `PrintHandler` to handle all levels and logging some
stuff is super easy:

```swift
import Logger

Logger.handlers.append(Logger.PrintHandler())

Logger.log(.debug, "log some debugging information")
Logger.log(.warning, "something happened that requires a warning")
```

Setting up the built-in `PrintHandler` and creating and setting up a custom
handler that only outputs logs with level `.verbose` as `UIAlertController`s
is also really easy:

```swift
import UIKit
import Logger

public struct AlertHandler: Logger.Handler {
    public let isLevelQualified: (Logger.Level) -> Bool
    
    public init(isLevelQualified: @escaping (Logger.Level) -> Bool) {
        self.isLevelQualified = isLevelQualified
    }
    
    public func log(_ level: Logger.Level, _ message: @autoclosure () -> String, _ args: [String] = [String](), file: StaticString, line: Int, function: StaticString) {
        let title = "Oops, an error occured"
        let alertView = UIAlertController(title: title, message: expandArgs(message(), args), preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        guard let presenter = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController ?? UIApplication.shared.keyWindow?.rootViewController else {
            Logger.log(.error, "It was not possible to get the currently presented viewcontroller from the keywindows rootviewcontroller, and it was therefore not possible to present an alert for the user with title %1 and message: %2", [title, message()])
            return
        }
        presenter.present(alertView, animated: true, completion: nil)
    }
}

Logger.handlers.append(Logger.PrintHandler())
Logger.handlers.append(AlertHandler { $0 == .verbose })

Logger.log(.debug, "log something that the PrintHandler will output")
Logger.log(.verbose, "log something that both the PrintHandler and the AlertHandler will output")
```

For more information, see the [Documentation](DOCUMENTATION.md).

## Version Compatibility

Note that we're aggressive about pushing `master` forward along with new
versions of Swift. Therefore, we highly recommend against pointing at `master`,
and instead using [one of the releases we've provided][releases].

Here is the current Swift compatibility breakdown:

| Swift Version | Logger Version |
| ------------- | -------------- |
| 3.X           | 0.1.X          |


[releases]: https://github.com/ChrisBuchholz/Logger/releases

## Installation

### [Swift Package Manager]

[Swift Package Manager]: https://swift.org/package-manager/

Add the following line to your `dependencies` list in your `Package.swift`:

```
.Package(url: "https://github.com/ChrisBuchholz/Logger.git",
majorVersion: 0, minor: 1),
```

### [Carthage]

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your Cartfile:

```
github "ChrisBuchholz/Logger"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

### CocoaPods

Support for CocoaPods are coming. Do feel welcome to make a pull-request for
this feature.

## Contributing

See the [CONTRIBUTING] document. Thank you, [contributors]!

[CONTRIBUTING]: CONTRIBUTING.md
[contributors]: https://github.com/ChrisBuchholz/Logger/graphs/contributors

## License

Logger is Copyright (c) 2016 Christoffer Buchholz. It is free software, and
may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE
