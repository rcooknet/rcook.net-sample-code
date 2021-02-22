/*:

 ## Service Locators: Anti-Pattern or Just Minunderstood

 Read the corresponding post to these code snippets at [https://www.rcook.net/articles/service-locators-anti-pattern-or-just-misunderstood/](https://www.rcook.net/articles/service-locators-anti-pattern-or-just-misunderstood/)

 ## Contents

 * [The Service Locator](#)
 * [Advantage - Reducing Init Clutter](ReducingInitClutter)
 * [Advantage - Pass Through Dependencies](PassThroughDependencies)
 * [Alternative - Dependency Injection](DependencyInjection)
 * [Alternative - Service Locator Injection](ServiceLocatorInjection)

 ## Example Definition and Usage of a Service Locator

 Here is a sample of a Service Locator I recently used in a SpriteKit project. It allows either the registration of an object or a recipe that vends a needed object type.

 As you can see, this class is designed to be used as a global static class. The Service Locator would be available at all levels of scope and maintain a single global registry of objects or recipes to vend upon demand.
 */

import Foundation

final class ServiceLocator {
    private static var services: [ObjectIdentifier: Any] = [:]

    private init() { }

    static func register<T>(_ recipe: @escaping () -> T) {
        services[ObjectIdentifier(T.self)] = recipe
    }

    static func register<T>(_ object: T) {
        services[ObjectIdentifier(T.self)] = object
    }

    static func resolve<T>() -> T? {
        if let object: T = services[ObjectIdentifier(T.self)] as? T {
            return object
        }
        if let recipe: () -> T = services[ObjectIdentifier(T.self)] as? () -> T {
            return recipe()
        }
        return nil
    }

    static func reset() {
        services = [:]
    }
}

// define a sample protocol to store in the service locator
protocol DataServiceProtocol {
    var data: String { get set }
}

// define a concrete implementation of the protocol
final class DataService: DataServiceProtocol {
    var data: String = ""

    init(data: String) {
        self.data = data
    }
}

// create and register the service class
let dataService = DataService(data: "my data")
ServiceLocator.register(dataService as DataServiceProtocol)

// lookup the service in the locator and use it
let service: DataServiceProtocol? = ServiceLocator.resolve()
print(service?.data ?? "")          // prints "my data"
