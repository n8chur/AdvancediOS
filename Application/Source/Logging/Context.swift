import Logger

extension Logger.Context {
    static let application = Logger.shared.contextManager.context("Application")
}
