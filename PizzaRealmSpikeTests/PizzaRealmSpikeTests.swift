import XCTest
import RealmSwift
@testable import PizzaRealmSpike

class PizzaRealmSpikeTests: XCTestCase {

    var testRealm: Realm!
    var controller: PizzaRepository!
    var pepperoniPizza: Pizza!
    var sausagePizza: Pizza!

    override func setUp() {
        testRealm = try! Realm(
            configuration: Realm.Configuration(inMemoryIdentifier: "pizza-controller-spec")
        )

        controller = PizzaRepository(realm: testRealm)

        pepperoniPizza = Pizza()
        pepperoniPizza.name = "Pepperoni"

        sausagePizza = Pizza()
        sausagePizza.name = "Sausage"
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

    func testGetPizzaFromRealmSuccess() {
    setUpRealm([pepperoniPizza, sausagePizza])

        let pizza = controller.getPizzaByName("Pepperoni")
        XCTAssertEqual(pizza!.name, "Pepperoni")
    }

    func testGetPizzasReturnsAllPizzas() {
        let expectedPizzas = [pepperoniPizza, sausagePizza]
        setUpRealm(expectedPizzas as! [Pizza])

        let pizzas = controller.getPizzas()
        XCTAssertEqual(pizzas.count, 2)

        let sortedPizzas = pizzas.sorted(by: { $0.name < $1.name } )
        XCTAssertEqual(sortedPizzas.first!.name, "Pepperoni")
        XCTAssertEqual(sortedPizzas.last!.name, "Sausage")
    }

    func setUpRealm(_ pizzas: [Pizza]) {
        for pizza in pizzas {
            try! testRealm.write {
                self.testRealm.add(pizza)
            }
        }

        XCTAssertEqual(testRealm.objects(Pizza.self).count, pizzas.count)
    }

}
