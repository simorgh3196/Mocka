public class Then<Mocking: Mock, Input, Output> {

    let methodSignature: MethodSignature<Mocking, Input, Output>

    init(methodSignature: MethodSignature<Mocking, Input, Output>) {
        self.methodSignature = methodSignature
    }

    @discardableResult
    public func then(return values: Output...) -> Then<Mocking, Input, Output> {
        let initial = then(return: values.first!)
        return values.dropFirst().reduce(initial) { result, value in
            result.then(return: value)
        }
    }

    @discardableResult
    public func then(return value: Output) -> Then<Mocking, Input, Output> {
        let stub = ConcreateStubMethod<Mocking, Input, Output>(
            identifier: methodSignature.identifier,
            matcher: methodSignature.matcher,
            action: { _ in value }
        )
        methodSignature.mock?.stubMethodHolder.register(stub: stub)
        return self
    }

    @discardableResult
    public func then(return action: @escaping ((Input) -> Output)) -> Then<Mocking, Input, Output> {
        let stub = ConcreateStubMethod<Mocking, Input, Output>(
            identifier: methodSignature.identifier,
            matcher: methodSignature.matcher,
            action: action
        )
        methodSignature.mock?.stubMethodHolder.register(stub: stub)
        return self
    }
}

public class ThenThrows<Mocking: Mock, Input, Output> {

    let methodSignature: MethodSignature<Mocking, Input, Output>

    init(methodSignature: MethodSignature<Mocking, Input, Output>) {
        self.methodSignature = methodSignature
    }

    @discardableResult
    public func then(return values: Output...) -> ThenThrows<Mocking, Input, Output> {
        let initial = then(return: values.first!)
        return values.dropFirst().reduce(initial) { result, value in
            result.then(return: value)
        }
    }

    @discardableResult
    public func then(return value: Output) -> ThenThrows<Mocking, Input, Output> {
        let stub = ConcreateStubMethod<Mocking, Input, Output>(
            identifier: methodSignature.identifier,
            matcher: methodSignature.matcher,
            action: { _ in value }
        )
        methodSignature.mock?.stubMethodHolder.register(stub: stub)
        return self
    }

    @discardableResult
    public func then(return action: @escaping ((Input) -> Output)) -> ThenThrows<Mocking, Input, Output> {
        let stub = ConcreateStubMethod<Mocking, Input, Output>(
            identifier: methodSignature.identifier,
            matcher: methodSignature.matcher,
            action: action
        )
        methodSignature.mock?.stubMethodHolder.register(stub: stub)
        return self
    }
}
