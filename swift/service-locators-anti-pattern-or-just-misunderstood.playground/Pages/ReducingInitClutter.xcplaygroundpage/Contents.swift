//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
/*:
 ## Advantage - Reducing Init Clutter

 In this sample code you can see the `DataManager` class defines several services it depends on. For this example there are only three, but imagine the size of the `init()` as your project grows, especially for those core service or manager classes.

 In the second class, the `LocatorDataManager` uses a Service Locator as the source of its services. The manager class retrieves the service from the Service Locator where it needs it. This can not only reduce `init()` clutter, but can also help with retain cycles as this manager does not retain any of the services it is using.
 */

import Foundation

// some sample service protocol definitions
protocol DataService { }
protocol DatabaseService { }
protocol NetworkService {
    func fetchData()
}

// manager class specifying all dependencies in the init()
final class DataManager {
    init(dataServce: DataService, networkService: NetworkService,
         databaseService: DatabaseService) { }
}

// manager class using Service Locator as needed
final class LocatorDataManager {
    init() { }

    func fetchDataFromNetwork() {
        let networkService: NetworkService? = ServiceLocator.resolve()
        networkService?.fetchData()
    }
}

//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
