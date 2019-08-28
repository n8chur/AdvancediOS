import RxSwift

public extension ObservableType {

    func logValue(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping (Self.Element) -> String) -> Observable<Self.Element> {
        return self.do(onNext: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
    }

    func logCompleted(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.Element> {
        return self.do(onCompleted: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    func logFailed(_ level: LogLevel = .error, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping (Error) -> String) -> Observable<Self.Element> {
        return self.do(onError: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
    }

    func logSubscribe(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.Element> {
        return self.do(onSubscribe: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    func logSubscribed(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.Element> {
        return self.do(onSubscribed: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    func logDispose(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping () -> String) -> Observable<Self.Element> {
        return self.do(onDispose: { Logger.shared.log(level, context, message(), file: file, function: function, line: line) })
    }

    func logEvent(_ level: LogLevel, _ context: Logger.Context, file: StaticString = #file, function: StaticString = #function, line: Int = #line, message: @escaping (Event<Self.Element>) -> String) -> Observable<Self.Element> {
        return self
            .materialize()
            .do(onNext: { Logger.shared.log(level, context, message($0), file: file, function: function, line: line) })
            .dematerialize()
    }

}
