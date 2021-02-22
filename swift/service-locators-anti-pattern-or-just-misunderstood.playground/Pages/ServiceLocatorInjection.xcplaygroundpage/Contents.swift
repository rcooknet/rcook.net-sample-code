//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
/*:
 ## Alternative - Service Locator Injection

 In this sample code you can see the `ServiceLocatorInstance` is stored as a dependency of the `DataManager` class and is used to fetch the `NetworkService` when it is needed.

 While this does not exactly outline all the classes the manager is dependent on, it does indicate that a Service Locator is involved up front, rather than the Service Locator being buried deep in the class where it is used.
 */

import Foundation

// some sample service protocol definitions
protocol DataService: class { }
protocol DatabaseService: class { }
protocol NetworkService: class {
    func fetchData()
}

// manager class taking a service locator instance as a dependency
final class DataManager {
    private weak var serviceLocator: ServiceLocatorInstance?

    init(serviceLocator: ServiceLocatorInstance) {
        self.serviceLocator = serviceLocator
    }

    func fetchDataFromNetwork() {
        let networkService: NetworkService? = serviceLocator?.resolve()
        networkService?.fetchData()
    }
}

//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
