import RxSwift

public extension ObservableType {

    public func logValue(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping (Self.E) -> String) -> Observable<Self.E> {
        return self.do(onNext: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
    }

    public func logCompleted(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.E> {
        return self.do(onCompleted: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logFailed(_ level: LogLevel = .error, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping (Error) -> String) -> Observable<Self.E> {
        return self.do(onError: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
    }

    public func logSubscribe(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.E> {
        return self.do(onSubscribe: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logSubscribed(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.E> {
        return self.do(onSubscribed: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logDispose(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.E> {
        return self.do(onDispose: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    public func logEvent(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping (Event<Self.E>) -> String) -> Observable<Self.E> {
        return self
            .materialize()
            .do(onNext: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
            .dematerialize()
    }

}
