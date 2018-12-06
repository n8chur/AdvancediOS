import CocoaLumberjackSwift

class LogFormatter: NSObject, DDLogFormatter {

    func format(message logMessage: DDLogMessage) -> String? {
        let name = flagName(logMessage.flag)
        let prefix = "\(name): "
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
