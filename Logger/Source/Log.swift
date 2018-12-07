import CocoaLumberjackSwift

public struct Log {

    public func verbose(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.verbose, context, message, file: file, function: function, line: line)
    }

    static public func debug(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.debug, context, message, file: file, function: function, line: line)
    }

    static public func info(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.info, context, message, file: file, function: function, line: line)
    }

    static public func warn(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.warn, context, message, file: file, function: function, line: line)
    }

    static public func error(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Logger.shared.log(.error, context, message, file: file, function: function, line: line)
    }

}

/// A logger intended to be used as a singleton.
public struct Logger {

    /// A logging context.
    /// This must be created through a Logger's ContextManager.
    public struct Context {
        public typealias Identifier = String
        public typealias Index = Int

        let index: Index
        public let identifier: Identifier
    }

    public class ContextManager {

        private var list: [Context] = []

        /// Retuns an existing Context for the provided identifier if it exists,
        /// otherwise creates a new Context and returns it.
        public func context(_ identifier: Context.Identifier) -> Context {
            if let context = list.first(where: { $0.identifier == identifier }) {
                return context
            }

            var index = 0
            if let maxIndex = list.map({ $0.index }).sorted().last {
                index = maxIndex + 1
            }

            let context = Context(index: index, identifier: identifier)
            list.append(context)

            return context
        }

        func identifier(for index: Context.Index) -> String {
            guard let context = list.first(where: { $0.index == index }) else {
                fatalError("Context requested at an index that does not exist")
            }

            return context.identifier
        }

    }

    public static let shared = Logger()

    /// The context manager reponsible for creating new contexts for logging.
    public let contextManager = ContextManager()

    private let fileLogger: DDFileLogger

    private init() {
        let logFormatter = LogFormatter(contextManager: contextManager)

        fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        fileLogger.logFormatter = logFormatter
        DDLog.add(fileLogger, with: .info)

        let osLogger = DDOSLogger()
        osLogger.logFormatter = logFormatter
        DDLog.add(osLogger)

        // Do not show verbose or debug logs in non-debug builds.
        #if DEBUG
            dynamicLogLevel = .all
        #else
            dynamicLogLevel = .info
        #endif
    }

    public func log(_ level: LogLevel, _ context: Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        switch level {
        case .verbose: DDLogVerbose(message, context: context.index, file: file, function: function, line: line)
        case .debug: DDLogDebug(message, context: context.index, file: file, function: function, line: line)
        case .info: DDLogInfo(message, context: context.index, file: file, function: function, line: line)
        case .warn: DDLogWarn(message, context: context.index, file: file, function: function, line: line)
        case .error: DDLogError(message, context: context.index, file: file, function: function, line: line)
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
