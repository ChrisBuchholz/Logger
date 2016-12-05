public struct PrintHandler: Logger.Handler {
    public let isLevelQualified: (Logger.Level) -> Bool
    
    public init(isLevelQualified: ((Logger.Level) -> Bool)? = nil) {
        if let isLevelQualified = isLevelQualified {
            self.isLevelQualified = isLevelQualified
        } else {
            self.isLevelQualified = { _ in true }
        }
    }
    
    public func log(_ level: Logger.Level, _ message: @autoclosure () -> String, _ args: [String] = [String](), file: StaticString, line: Int, function: StaticString) {
        print("\(level):")
        print("\t\(expandArgs(message(), args))")
        print("\t\(file), line \(line) in \(function)")
    }
}
