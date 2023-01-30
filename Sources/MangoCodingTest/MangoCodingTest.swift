import Foundation

class Dependencies {
    private var dependencies = [String: Set<String>]()

    func addDependencies(item: String, dependencies: Set<String>) {
        if let _ = self.dependencies[item] {
            print(DependencyError.itemAlreadyExists.description)
            return
        }

        self.dependencies[item] = dependencies
    }
    
    func removeDependency(item: String) {
        if self.dependencies.removeValue(forKey: item) != nil {
            print(DependencyError.itemNotFound.description)
        }
    }
    
    func dependenciesFor(item: String) -> Set<String> {
        var result: Set<String> = []
        var visitedItems: Set<String> = []
        var itemQueue = [item]

        while !itemQueue.isEmpty {
            let item = itemQueue.removeFirst()
            if visitedItems.contains(item) {
                print("\(DependencyError.circularDependency.description) found: \(item)")
                return []
            }
            visitedItems.insert(item)
            
            if let directDependencie = dependencies[item] {
                result.formUnion(directDependencie)
                itemQueue.append(contentsOf: directDependencie)
            }
        }
        return result
    }
}
