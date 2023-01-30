import XCTest
@testable import MangoCodingTest

final class MangoCodingTestTests: XCTestCase {
    
    func testDependenciesFor() {
        //testBasic
        let dependencies = Dependencies()
        dependencies.addDependencies(item: "A", dependencies: ["B", "C"])
        dependencies.addDependencies(item: "B", dependencies: ["C", "E"])
        dependencies.addDependencies(item: "C", dependencies: ["G"])
        dependencies.addDependencies(item: "D", dependencies: ["A", "F"])
        dependencies.addDependencies(item: "E", dependencies: ["F"])
        dependencies.addDependencies(item: "F", dependencies: ["H"])
    
        XCTAssertNotEqual(dependencies.dependenciesFor(item: "A"), ["B", "C", "E", "F", "G", "H"], "CircularDependency")
        XCTAssertEqual(dependencies.dependenciesFor(item: "B"), ["C", "E", "F", "G", "H"])
        XCTAssertEqual(dependencies.dependenciesFor(item: "C"), ["G"])
        XCTAssertNotEqual(dependencies.dependenciesFor(item: "D"), ["A", "B", "C", "E", "F", "G", "H"], "CircularDependency")
        XCTAssertEqual(dependencies.dependenciesFor(item: "E"), ["F", "H"])
        XCTAssertEqual(dependencies.dependenciesFor(item: "F"), ["H"])
    }
    
    func testCircularDependency() {
        let dependencies = Dependencies()
        dependencies.addDependencies(item: "A", dependencies: ["B"])
        dependencies.addDependencies(item: "B", dependencies: ["C"])
        dependencies.addDependencies(item: "C", dependencies: ["A"])
        
        XCTAssertNotEqual(dependencies.dependenciesFor(item: "A"), ["B", "C", "A"], "CircularDependency")
    }
    
        
    func testAddDependencies() {
        let dependencies = Dependencies()
        dependencies.addDependencies(item: "A", dependencies: ["B", "C"])
        
        XCTAssertEqual(dependencies.dependenciesFor(item: "A"), ["B", "C"])
    }
    
    func testRemoveDependency() {
        let dependencies = Dependencies()
        dependencies.addDependencies(item: "A", dependencies: ["B", "C"])
        dependencies.removeDependency(item: "A")
        
        XCTAssertEqual(dependencies.dependenciesFor(item: "A"), [])
    }
    
    
    func testAddDependenciesDuplicateItem() {
        let dependencies = Dependencies()
        dependencies.addDependencies(item: "A", dependencies: ["B", "C"])
        dependencies.addDependencies(item: "A", dependencies: ["D", "E"])
        
        XCTAssertEqual(dependencies.dependenciesFor(item: "A"), ["B", "C"])
    }
        
    func testMultipleDependencies() {
        let dependencies = Dependencies()
        dependencies.addDependencies(item: "A", dependencies: ["B","C"])
        dependencies.addDependencies(item: "B", dependencies: ["D"])
        dependencies.addDependencies(item: "C", dependencies: ["E"])
        
        XCTAssertEqual(dependencies.dependenciesFor(item: "A"), ["B","C","D","E"])
    }
    
    func testEmptyDependencies() {
        let dependencies = Dependencies()
        dependencies.addDependencies(item: "A", dependencies: [])
        
        XCTAssertEqual(dependencies.dependenciesFor(item: "A"), [])
    }
    
    func testDependenciesForNonExistentItem() {
        let dependencies = Dependencies()
        
        XCTAssertEqual(dependencies.dependenciesFor(item: "A"), [])
    }
    
    func testDependenciesForItemNotInDependencies() {
        let deps = Dependencies()
        deps.addDependencies(item: "A", dependencies: ["B", "C"])
        
        XCTAssertEqual(deps.dependenciesFor(item: "D"), [])
    }
    
}
