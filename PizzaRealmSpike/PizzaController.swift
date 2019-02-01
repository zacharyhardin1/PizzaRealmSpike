import RealmSwift

class PizzaController {

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
}
