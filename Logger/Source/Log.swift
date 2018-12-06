import CocoaLumberjackSwift

public struct Log {

    public func verbose(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.verbose, message, file: file, function: function, line: line)
    }

    static public func debug(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.debug, message, file: file, function: function, line: line)
    }

    static public func info(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.info, message, file: file, function: function, line: line)
    }

    static public func warn(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.warn, message, file: file, function: function, line: line)
    }

    static public func error(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.error, message, file: file, function: function, line: line)
    }

}

public struct Logger {

    public static let shared: Logger = {
        let ttyLogger = DDOSLogger.sharedInstance!

        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7

        return Logger(ttyLogger: ttyLogger, fileLogger: fileLogger)
    }()

    private let fileLogger: DDFileLogger

    private init(ttyLogger: DDAbstractLogger, fileLogger: DDFileLogger) {
        self.fileLogger = fileLogger

        let logFormatter = LogFormatter()

        ttyLogger.logFormatter = logFormatter
        fileLogger.logFormatter = logFormatter

        DDLog.add(ttyLogger)
        DDLog.add(fileLogger, with: .info)

        #if DEBUG
            dynamicLogLevel = .all
        #else
            dynamicLogLevel = .info
        #endif
    }

    public func log(_ level: LogLevel, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        switch level {
        case .verbose: DDLogVerbose(message, file: file, function: function, line: line)
        case .debug: DDLogDebug(message, file: file, function: function, line: line)
        case .info: DDLogInfo(message, file: file, function: function, line: line)
        case .warn: DDLogWarn(message, file: file, function: function, line: line)
        case .error: DDLogError(message, file: file, function: function, line: line)
        }
    }

    public var logFileURLs: [URL] {
        return fileLogger.logFileManager.unsortedLogFilePaths
            .map { URL.init(fileURLWithPath: $0, isDirectory: false) }
    }

}

public enum LogLevel {
    case verbose
    case debug
    case info
    case warn
    case error
}
