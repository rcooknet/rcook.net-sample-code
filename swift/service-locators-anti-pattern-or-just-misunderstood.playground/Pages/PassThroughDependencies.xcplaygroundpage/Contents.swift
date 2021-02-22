//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
/*:
 ## Advantage - Eliminating Pass Through Dependencies

 Another area the Service Locator helps to improve code readability and control dependency explosion is to eliminate the pass through dependency.

 As you can see in the code sample below, the `Manager` class never uses the `dataService` property that is required to initialize it. The `Manager` class only uses the `dataService` property to create the `Worker` object when needed.

 In the second section of code below, notice how much cleaner the `init()` methods are for the `LocatingManager` and `LocatingWorker`, and the `LocatingManager` no longer needs to hold onto a `DataService` property that it only uses to pass along during creation of the `Worker` class.
 */

import Foundation

// MARK: - Manager class with pass-thru dependencies

protocol DataService {
    func fetchData()
}

// manager class that has to keep a service property it only passes along to the Worker
final class Manager {
    private var dataService: DataService

    init(dataService: DataService) {
        self.dataService = dataService
    }

    func doSomeWork() {
        let worker = Worker(dataService: dataService)
        worker.doWork()
    }
}

// worker class that has a dependency on a DataService class
final class Worker {
    private var dataService: DataService

    init(dataService: DataService) {
        self.dataService = dataService
    }

    func doWork() {
        dataService.fetchData()
    }
}

// MARK: - Manager and Worker classes using the Service Locator

// manager class using a LocatingWorker which uses a ServiceLocator
final class LocatingManager {
    init() { }

    func doSomeWork() {
        let worker = LocatingWorker()
        worker.doWork()
    }
}

// worker class that uses a ServiceLocator for its dependency on a DataService class
final class LocatingWorker {
    init() { }

    func doWork() {
        let dataService: DataService? = ServiceLocator.resolve()
        dataService?.fetchData()
    }
}

//: [Previous](@previous) / [Top](ServiceLocator) / [Next](@next)
