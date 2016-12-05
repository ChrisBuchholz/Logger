import Foundation

public enum Level: Int {
    case fatal
    case error
    case warning
    case info
    case debug
    case verbose
}

public var handlers: [Handler] = []

public func log(_ level: Level, _ message: @autoclosure () -> String, _ args: [String] = [String](), file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
    for handler in handlers {
        if handler.isLevelQualified(level) {
            handler.log(level, message, args, file: file, line: line, function: function)
        }
    }
}

public func log(_ level: Level, _ error: Error, _ args: [String] = [String](), file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
    log(level, "\(error)", args, file: file, line: line, function: function)
}

extension Level: Comparable {}

public func <(lhs: Level, rhs: Level) -> Bool {
    return lhs.rawValue < rhs.rawValue
}
