import RealmSwift

class PizzaRepository {

    let realm: Realm!

    init(realm: Realm) {
        self.realm = realm
    }

    convenience init() {
        self.init(realm: try! Realm())
    }

    func addPizza(pizza: Pizza) {
        try! realm.write {
            self.realm.add(pizza)
        }
    }

    func getPizzaByName(_ name: String) -> Pizza? {
        let pizza = realm.objects(Pizza.self).filter("name == %@", name)
        return pizza.first
    }

    func getPizzas() -> [Pizza] {
        let pizzas = realm.objects(Pizza.self)
        return Array(pizzas)
    }
}
