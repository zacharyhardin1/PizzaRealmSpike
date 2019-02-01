import XCTest
import RealmSwift
@testable import PizzaRealmSpike

class PizzaRealmSpikeTests: XCTestCase {

    var testRealm: Realm!
    var controller: PizzaController!

    override func setUp() {
        testRealm = try! Realm(
            configuration: Realm.Configuration(inMemoryIdentifier: "pizza-controller-spec")
        )

        controller = PizzaController(realm: testRealm)
    }

    override func tearDown() {
        try! testRealm.write {
            testRealm.deleteAll()
        }
    }

    func testAddPizzaToRealm() {
        XCTAssertEqual(testRealm.objects(Pizza.self).count, 0)

        let pizza = Pizza()
        pizza.name = "Taco Pizza"
        controller.addPizza(pizza: pizza)

        XCTAssertEqual(testRealm.objects(Pizza.self).count, 1)
        XCTAssertEqual(testRealm.objects(Pizza.self).first!.name, "Taco Pizza")
    }

}
