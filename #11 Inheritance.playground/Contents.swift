import Foundation

// Виды магического оружия (Урон)
enum MagicWeapon: Int {
    case woodenStick = 50
    case scholarBook = 100
    case branchOfMatherTree = 200
    case staffOfMadness = 500
}

// Виды оружия ближнего боя (Урон)
enum MeleeWeapon: Int {
    case woodenSword = 30
    case captainRapier = 80
    case demonSword = 150
    case excalibur = 300
}

//MARK: - Базовый класс - Авантюрист
class Adventurer {
    //MARK: Свойства
    let nickName: String /// Никнейм
    var guild: String? /// Название гильдии
    fileprivate var hp: Int = 0 { /// Очки жизни
        didSet {
            if hp <= 0 {
                print("Ты умер. Отправляйся на респаун!")
            }
        }
    }
    fileprivate var lvl: Int /// Уровень
    fileprivate var damage: Int = 0  /// Наносимый урон
    
    //MARK: Инициализатор
    init(nickName: String, lvl: Int) {
        self.nickName = nickName
        self.lvl = lvl
        getNewCharacteristics()
    }
    
    //MARK: Публичные и внутренние функции (internal по дефолту)
    public func getStatusInfo() {
        print("""
        Lvl.\(lvl) \(nickName)
        Guild: \(guild ?? "No guild")
        HP: \(hp)
        """)
    }
    
    func attack(_ monster: Monster) {
        monster.getDamage(damage)
    }
    
    func getDamage(_ damage: Int) {
        hp -= damage
    }
    
    //MARK: - Приватная функция
    fileprivate func getNewCharacteristics() {
        hp = lvl * lvl * 50
        damage = 10 + lvl * lvl
    }
}


//MARK: - Класс наследник - Воин
class Warrior: Adventurer {
    //MARK: Свойства
    private let classAdventurer = "Warrior"
    private var weapon: MeleeWeapon?
    private var barrier: Bool = false // Барьер (доп защита)
    private var secondLife = 1 // Индикатор второй жизни
    
    //MARK: Переопределенное свойство
    override var hp: Int {
        didSet {
            if hp <= 0 {
                if secondLife != 0 {
                    getSecondLife()
                } else {
                    print("Ты умер. Отправляйся на респаун!")
                }
            }
        }
    }
    
    //MARK: Дополнительный иницилизатор
    convenience init(nickName: String, lvl: Int, weapon: MeleeWeapon) {
        self.init(nickName: nickName, lvl: lvl)
        self.weapon = weapon
    }
    
    // Включает / выключает барьер
    func changeStatusBarrier() {
        barrier.toggle()
    }
    
    //MARK: Переопределяемые функции
    override func attack(_ monster: Monster) {
        let damage = damage + (weapon?.rawValue ?? 0)
        monster.getDamage(damage)
    }
    
    override func getDamage(_ damage: Int) {
        guard let miss = (1...10).randomElement() else { return }
        if miss > 3 {
            hp -= barrier == true ? damage * 4 / 5 : damage
        } else {
            print("Промах!")
        }
    }
    
    override func getNewCharacteristics() {
        hp = lvl * lvl * lvl * 10
        damage = lvl * lvl * 50
    }
    
    override func getStatusInfo() {
        super.getStatusInfo()
        print("Class: \(classAdventurer)")
    }
    
    //MARK: Приватная функция
    private func getSecondLife() {
        hp += lvl * lvl * lvl * 5
        print("Вторая жизнь")
        secondLife -= 1
    }
}


//MARK: - Класс наследник - Маг
class Mage: Adventurer {
    //MARK: Свойства
    private let classAdventurer = "Mage"
    private var weapon: MagicWeapon?
    
    //MARK: Переопределенное свойство
    override var hp: Int {
        didSet {
            if hp <= 0 {
                print("Ты умер. Отправляйся на респаун!")
            } else {
                if hp < lvl * lvl * lvl * 3 {
                    hp += lvl * 5 // Восстановление
                }
            }
        }
    }
    
    //MARK: Дополнительный иницилизатор
    convenience init(nickName: String, lvl: Int, weapon: MagicWeapon) {
        self.init(nickName: nickName, lvl: lvl)
        self.weapon = weapon
    }
    
    //MARK: Переопределяемые функции
    override func attack(_ monster: Monster) {
        guard let superHit = (1...10).randomElement() else { return }
        var damage = damage + (weapon?.rawValue ?? 0)
        if superHit == 10 {
            damage *= 2
            print("Супер удар!")
        }
        monster.getDamage(damage)
    }
    
    override func getNewCharacteristics() {
        hp = lvl * lvl * lvl * 3
        damage = Int(pow(2, Double(lvl + 1))) + 50
    }
    
    override func getStatusInfo() {
        super.getStatusInfo()
        print("Class: \(classAdventurer)")
    }
}


//MARK: - Базовый класс - Монстер
class Monster {
    let name: String
    fileprivate var lvl: Int
    fileprivate var hp: Int = 100 {
        didSet {
            if hp < 0 {
                print("\(name) повержен!")
            }
        }
    }
    fileprivate var damage: Int = 10 /// Урон
    
    init(name: String, lvl: Int) {
        self.name = name
        self.lvl = lvl
        getNewCharacteristics()
    }
    
    /// Атакует авантюриста
    func attack(_ adventurer: Adventurer) {
        adventurer.getDamage(damage)
    }
    
    /// Получение урона
    func getDamage(_ damage: Int) {
        hp -= damage
    }
    
    /// Устанавливает характеристики
    fileprivate func getNewCharacteristics() {
        hp = lvl * 100
        damage = lvl * 10
    }
}

//MARK: - Класс наследник - Троль
class Troll: Monster {
    override func getNewCharacteristics() {
        hp = lvl * 200
        damage = lvl * 20
    }
}

// Запускает битву между авантюристом и монстром
func battle(_ adventurer: Adventurer, vs monster: Monster) {
    while adventurer.hp > 0 && monster.hp > 0 {
        adventurer.attack(monster)
        monster.attack(adventurer)
    }
    
    if adventurer.hp < 0 && monster.hp < 0 {
        print("Убили друг друга")
    } else if adventurer.hp < 0 {
        print("Вы проиграли")
    } else {
        print("Безоговорочная победа!")
    }
}

//MARK: - Примеры работы и Полиморфизм
let mage = Mage(nickName: "Ded Moroz", lvl: 7, weapon: .scholarBook)
let monster = Troll(name: "Uruk", lvl: 50)

mage.guild = "Dragons"
battle(mage, vs: monster)

print("________________________")
let warrior = Warrior(nickName: "Konan", lvl: 6)
let monster2 = Troll(name: "Torn", lvl: 45)

warrior.changeStatusBarrier()
battle(warrior, vs: monster2)

print("________________________")
let duelist: Adventurer = Warrior(nickName: "Jack Vorobey", lvl: 8, weapon: .captainRapier)
let adventurer: Adventurer = Adventurer(nickName: "Winny the Pooh", lvl: 3)

[mage, warrior, duelist, adventurer].forEach {
    $0.getStatusInfo()
    print("________________________")
}
