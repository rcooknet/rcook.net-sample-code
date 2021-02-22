import Foundation

public final class ServiceLocatorInstance {
    private var services: [ObjectIdentifier: Any] = [:]

    init() { }

    public func register<T>(_ recipe: @escaping () -> T) {
        services[ObjectIdentifier(T.self)] = recipe
    }

    public func register<T>(_ object: T) {
        services[ObjectIdentifier(T.self)] = object
    }

    public func resolve<T>() -> T? {
        if let object: T = services[ObjectIdentifier(T.self)] as? T {
            return object
        }
        if let recipe: () -> T = services[ObjectIdentifier(T.self)] as? () -> T {
            return recipe()
        }
        return nil
    }

    public func reset() {
        services = [:]
    }
}
