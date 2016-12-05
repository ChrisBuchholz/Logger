import Foundation

public protocol Handler {
    var isLevelQualified: (Level) -> Bool { get }
    
    func log(_ logLevel: Level, _ message: @autoclosure () -> String, _ args: [String], file: StaticString, line: Int, function: StaticString)
}

public extension Handler {
    public func expandArgs(_ message: String, _ args: [String]) -> String {
        var newMessage = message
        for (i, v) in args.enumerated() {
            newMessage = newMessage.replacingOccurrences(of: "%\(i+1)", with: v)
        }
        return newMessage
    }
}
