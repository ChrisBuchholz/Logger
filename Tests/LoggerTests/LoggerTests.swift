import XCTest
@testable import Logger

public struct TestHandler: Logger.Handler {
    public let isLevelQualified: (Logger.Level) -> Bool
    
    public func log(_ level: Logger.Level, _ message: @autoclosure () -> String, _ args: [String] = [String](), file: StaticString, line: Int, function: StaticString) {
        // ...
    }
}

class LoggerTests: XCTestCase {
    func testHandlerLevelQualified() {
        let h1 = TestHandler(isLevelQualified: { $0 <= .fatal })
        
        XCTAssertEqual(h1.isLevelQualified(.fatal), true)
        XCTAssertEqual(h1.isLevelQualified(.error), false)
        
        let h2 = TestHandler(isLevelQualified: { $0 > .debug })
        
        XCTAssertEqual(h2.isLevelQualified(.verbose), true)
    }
    
    func testAddingHandler() {
        let handler = TestHandler(isLevelQualified: { _ in true })
        Logger.handlers.append(handler)
        XCTAssertEqual(Logger.handlers.count, 1)
    }

    static var allTests : [(String, (LoggerTests) -> () throws -> Void)] {
        return [
            ("testAddingHandler", testAddingHandler),
            ("testHandlerLevelQualified", testHandlerLevelQualified),
        ]
    }
}
