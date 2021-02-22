import Foundation

public final class ServiceLocator {
    private static var services: [ObjectIdentifier: Any] = [:]

    private init() { }

    public static func register<T>(_ recipe: @escaping () -> T) {
        services[ObjectIdentifier(T.self)] = recipe
    }

    public static func register<T>(_ object: T) {
        services[ObjectIdentifier(T.self)] = object
    }

    public static func resolve<T>() -> T? {
        if let object: T = services[ObjectIdentifier(T.self)] as? T {
            return object
        }
        if let recipe: () -> T = services[ObjectIdentifier(T.self)] as? () -> T {
            return recipe()
        }
        return nil
    }

    public static func reset() {
        services = [:]
    }
}
