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

/// A logger intended to be used as a singleton.
public struct Logger {

    public static let shared = Logger()

    private let fileLogger: DDFileLogger

    private init() {
        let logFormatter = LogFormatter()

        fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        fileLogger.logFormatter = logFormatter
        DDLog.add(fileLogger, with: .info)

        let ttyLogger = DDOSLogger.sharedInstance!
        ttyLogger.logFormatter = logFormatter
        DDLog.add(ttyLogger)

        // Do not show verbose or debug logs in non-debug builds.
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

    /// Returns an array of all existing log files.
    ///
    /// This could be used to upload log files for a support ticket or a crash report.
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
