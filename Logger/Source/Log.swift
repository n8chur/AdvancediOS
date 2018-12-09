import XCGLogger
import Foundation

public struct Log {

    public func verbose(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        Logger.shared.log(.verbose, context, message(), file: file, function: function, line: line)
    }

    static public func debug(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        Logger.shared.log(.debug, context, message(), file: file, function: function, line: line)
    }

    static public func info(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        Logger.shared.log(.info, context, message(), file: file, function: function, line: line)
    }

    static public func warn(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        Logger.shared.log(.warn, context, message(), file: file, function: function, line: line)
    }

    static public func error(_ context: Logger.Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        Logger.shared.log(.error, context, message(), file: file, function: function, line: line)
    }

}

/// A logger intended to be used as a singleton.
public struct Logger {

    /// A logging context.
    /// This must be created through a Logger's ContextManager.
    public struct Context {
        public typealias Identifier = String
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

            let context = Context(identifier: identifier)
            list.append(context)

            return context
        }

        func identifier(for identifier: Context.Identifier) -> String {
            guard let context = list.first(where: { $0.identifier == identifier }) else {
                fatalError("Context requested at an index that does not exist")
            }

            return context.identifier
        }

    }

    public static let shared = Logger()

    /// The context manager reponsible for creating new contexts for logging.
    public let contextManager = ContextManager()

    private let log = XCGLogger(identifier: "Logger", includeDefaultDestinations: false)

    private let fileDestination: AutoRotatingFileDestination

    private init() {
        #if DEBUG
            let osLogLogLevel: XCGLogger.Level  = .verbose
            let fileLogLevel: XCGLogger.Level = .debug
        #else
            let osLogLogLevel: XCGLogger.Level = .info
            let fileLogLevel: XCGLogger.Level = .info
        #endif

        let contextFormatter = ContextFormatter(contextManager: contextManager)
        let osLogFormatters = [ contextFormatter ]
        let osLogDestination = Logger.makeOSLogDestination(owner: log, outputLevel: osLogLogLevel, formatters: osLogFormatters)
        log.add(destination: osLogDestination)

        let ansiColorLogFormatter = Logger.makeColorFormatter()
        let fileFormatters: [LogFormatterProtocol] = [
            contextFormatter,
            ansiColorLogFormatter,
        ]
        fileDestination = Logger.makeFileDestination(owner: log, outputLevel: fileLogLevel, formatters: fileFormatters)
        log.add(destination: fileDestination)

        log.logAppDetails()
    }

    private static func makeFileDestination(owner: XCGLogger, outputLevel: XCGLogger.Level, formatters: [LogFormatterProtocol]? = nil) -> AutoRotatingFileDestination {
        let cachesPaths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        guard let baseURL = cachesPaths.last else {
            fatalError("Failed to get base caches directory.")
        }

        let logFolder = baseURL.appendingPathComponent("Logs", isDirectory: true)
        if !FileManager.default.fileExists(atPath: logFolder.path) {
            do {
                try FileManager.default.createDirectory(atPath: logFolder.path, withIntermediateDirectories: true)
            } catch let error as NSError {
                fatalError("Unable to create Logs directory: \(error.debugDescription)")
            }
        }

        let logFileURL = logFolder.appendingPathComponent("Log.log")

        let destination = AutoRotatingFileDestination(
            owner: owner,
            writeToFile: logFileURL,
            identifier: "Logger.autoRotatingFileDestination",
            attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication])
        destination.outputLevel = outputLevel
        destination.showLogIdentifier = false
        destination.showFunctionName = true
        destination.showThreadName = true
        destination.showLevel = true
        destination.showFileName = true
        destination.showLineNumber = true
        destination.showDate = true
        destination.logQueue = XCGLogger.logQueue
        destination.formatters = formatters
        return destination
    }

    private static func makeOSLogDestination(owner: XCGLogger, outputLevel: XCGLogger.Level, formatters: [LogFormatterProtocol]? = nil) -> OSLogDestination {
        let destination = OSLogDestination(owner: owner, identifier: "Logger.systemDestination")
        destination.outputLevel = outputLevel
        destination.showLogIdentifier = false
        destination.showFunctionName = true
        destination.showThreadName = true
        destination.showLevel = true
        destination.showFileName = true
        destination.showLineNumber = true
        // Do not include date since it's already printed in os_log
        destination.showDate = false
        destination.formatters = formatters
        return destination
    }

    private static func makeColorFormatter() -> ANSIColorLogFormatter {
        let formatter = ANSIColorLogFormatter()
        formatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
        formatter.colorize(level: .debug, with: .black)
        formatter.colorize(level: .info, with: .blue, options: [.underline])
        formatter.colorize(level: .warning, with: .red, options: [.faint])
        formatter.colorize(level: .error, with: .red, options: [.bold])
        formatter.colorize(level: .severe, with: .white, on: .red)
        return formatter
    }

    public func log(_ level: LogLevel, _ context: Context, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: Int = #line) {
        let userInfo = [ ContextFormatter.userInfoKey: context]
        switch level {
        case .verbose: log.verbose(function, fileName: file, lineNumber: line, userInfo: userInfo, closure: message)
        case .debug: log.debug(function, fileName: file, lineNumber: line, userInfo: userInfo, closure: message)
        case .info: log.info(function, fileName: file, lineNumber: line, userInfo: userInfo, closure: message)
        case .warn: log.warning(function, fileName: file, lineNumber: line, userInfo: userInfo, closure: message)
        case .error: log.error(function, fileName: file, lineNumber: line, userInfo: userInfo, closure: message)
        }
    }

    /// Returns an array of all existing log files.
    ///
    /// This could be used to upload log files for a support ticket or a crash report.
    public var logFileURLs: [URL] {
        return fileDestination.archivedFileURLs()
    }

}

public enum LogLevel {
    case verbose
    case debug
    case info
    case warn
    case error
}
