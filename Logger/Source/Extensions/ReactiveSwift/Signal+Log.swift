import ReactiveSwift
import Result

public extension Signal {

    public func logValue(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping (Value) -> String) -> Signal<Value, Error> {
        return on(value: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
    }

    public func logCompleted(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> Signal<Value, Error> {
        return on(completed: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logFailed(_ level: LogLevel = .error, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping (Error) -> String) -> Signal<Value, Error> {
        return on(failed: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
    }

    public func logInterruption(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> Signal<Value, Error> {
        return on(interrupted: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logTerminated(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> Signal<Value, Error> {
        return on(terminated: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logDisposed(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> Signal<Value, Error> {
        return on(disposed: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logEvent(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping (Event) -> String) -> Signal<Value, Error> {
        return on(event: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
    }

}

public extension SignalProducer {

    public func logValue(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping (Value) -> String) -> SignalProducer<Value, Error> {
        return lift { $0.logValue(level, context, file: file, function: function, line: line, message: message) }
    }

    public func logCompleted(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> SignalProducer<Value, Error> {
        return lift { $0.logCompleted(level, context, file: file, function: function, line: line, message: message) }
    }

    public func logFailed(_ level: LogLevel = .error, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping (Error) -> String) -> SignalProducer<Value, Error> {
        return lift { $0.logFailed(level, context, file: file, function: function, line: line, message: message) }
    }

    public func logInterruption(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> SignalProducer<Value, Error> {
        return lift { $0.logInterruption(level, context, file: file, function: function, line: line, message: message) }
    }

    public func logTerminated(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> SignalProducer<Value, Error> {
        return lift { $0.logTerminated(level, context, file: file, function: function, line: line, message: message) }
    }

    public func logDisposed(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> SignalProducer<Value, Error> {
        return lift { $0.logDisposed(level, context, file: file, function: function, line: line, message: message) }
    }

    public func logEvent(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping (Signal<Value, Error>.Event) -> String) -> SignalProducer<Value, Error> {
        return lift { $0.logEvent(level, context, file: file, function: function, line: line, message: message) }
    }

    public func logStarting(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> SignalProducer<Value, Error> {
        return on(starting: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logStarted(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, message: @escaping () -> String) -> SignalProducer<Value, Error> {
        return on(started: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

}
