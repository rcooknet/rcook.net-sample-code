//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
/*:
 ## Alternative - Dependency Injection

 As you can see in the sample code below, the dependencies of the `DataManager` class are clearly defined in its constructor. Any user of this class will have a clear understanding of the other class instances they will need to have available to make use of this class.
 */

import Foundation

// some sample service protocol definitions
protocol DataService: class { }
protocol DatabaseService: class { }
protocol NetworkService: class {
    func fetchData()
}

// manager class using dependency injection through the constructor
final class DataManager {
    private weak var dataService: DataService?
    private weak var databaseService: DatabaseService?
    private weak var networkService: NetworkService?

    init(dataServce: DataService, networkService: NetworkService,
         databaseService: DatabaseService) {
        self.dataService = dataServce
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func fetchDataFromNetwork() {
        networkService?.fetchData()
    }
}

//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
