#if swift(>=5.7)
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public
protocol AsyncTestEnvironment<Context>
{
    associatedtype Context

    func withContext<Success>(
        _ body:(Context) async throws -> Success) async rethrows -> Success
}
#elseif swift(>=5.5)
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public
protocol AsyncTestEnvironment
{
    associatedtype Context

    func withContext<Success>(
        _ body:(Context) async throws -> Success) async rethrows -> Success
}
#endif
