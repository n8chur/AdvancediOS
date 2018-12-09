import os.log
import XCGLogger
import Foundation

/// A logging destination that uses os_log if it is available, otherwise it uses NSLog.
///
/// Adapted from https://github.com/DaveWoodCom/XCGLogger/issues/258#issuecomment-405097749
open class OSLogDestination: BaseQueuedDestination {

    open override func output(logDetails: LogDetails, message: String) {
        var logDetails = logDetails
        var message = message

        if self.shouldExclude(logDetails: &logDetails, message: &message) {
            return
        }

        self.applyFormatters(logDetails: &logDetails, message: &message)

        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
            os_log("%@", type: logDetails.level.osLogType, message)
        } else {
            NSLog("%@", message)
        }
    }
}
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension XCGLogger.Level {
    var osLogType: OSLogType {
        switch self {
        case .verbose, .debug:
            return .debug
        case .info, .warning: /* warning as info, could be also error*/
            return .info
        case .error, .severe:
            return .error
        case .none:
            return .default
        }
    }
}
