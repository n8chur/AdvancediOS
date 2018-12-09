import XCGLogger

/// Formats XCGLogger messages.
///
/// Prefixes all messages with the flag name.
class LogFormatter: LogFormatterProtocol {

    static let userInfoKey = "Context"

    let contextManager: Logger.ContextManager

    init(contextManager: Logger.ContextManager) {
        self.contextManager = contextManager
    }

    func format(logDetails: inout LogDetails, message: inout String) -> String {
        guard let context = logDetails.userInfo[LogFormatter.userInfoKey] as? Logger.Context else {
            return message
        }
        message = "<\(context.identifier)> \(message): "
        return message
    }

    var debugDescription: String {
        return "\(type(of: self)): "
    }

}
