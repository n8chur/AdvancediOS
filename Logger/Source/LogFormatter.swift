import CocoaLumberjackSwift

/// Formats DDLog messages.
///
/// Prefixes all messages with the flag name.
///
/// Additionally adds the file name, line number, and calling function name to errors.
class LogFormatter: NSObject, DDLogFormatter {

    let contextManager: Logger.ContextManager

    init(contextManager: Logger.ContextManager) {
        self.contextManager = contextManager
    }

    func format(message logMessage: DDLogMessage) -> String? {
        let name = flagName(logMessage.flag)
        let contextIdentifier = contextManager.identifier(for: logMessage.context)
        let prefix = "[\(contextIdentifier)] \(name): "

        switch logMessage.flag {
        case .error:
            return "\(prefix)<\(logMessage.fileName):\(logMessage.line):\(String(describing: logMessage.function))> \(logMessage.message)"
        default:
            return "\(prefix)\(logMessage.message)"
        }
    }

    private func flagName(_ logFlag: DDLogFlag) -> String {
        switch logFlag {
        case .verbose:  return "V"
        case .info:     return "I"
        case .debug:    return "D"
        case .warning:  return "W"
        case .error:    return "E"
        default:        return "?"
        }
    }

}
