import Foundation

//MARK: Двунаправленный связанный список
final class DequeNode<T> {
    var value: T
    var next: DequeNode<T>?
    var previous: DequeNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

//MARK: Двухсторонняя очередь
final class Deque<T> {
    var head: DequeNode<T>?
    var tail: DequeNode<T>?
    
    /// Добавляет элементы в зависимости от приоритета
    ///  - Parameters:
    ///   - value: значение элемента
    ///   - priority: Приоритет
    func add(value: T, priority: Priority) {
        switch priority {
        case .high:
            pushFront(value: value)
        case .low:
            pushBack(value: value)
        }
    }
    
    /// Добавляет элемент в конец очереди
    ///  - Parameter value: значение элемента
    private func pushBack(value: T) {
        let newNode = DequeNode(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.previous = tailNode
            newNode.next = nil
            tail = newNode
        } else {
            newNode.previous = nil
            newNode.next = nil
            head = newNode
            tail = newNode
        }
    }
    
    /// Добавляет элемент в начало очереди
    ///  - Parameter value: значение элемента
    private func pushFront(value: T) {
        let newNode = DequeNode(value: value)
        if let headNode = head {
            headNode.previous = newNode
            newNode.previous = nil
            newNode.next = headNode
            head = newNode
        } else {
            newNode.previous = nil
            newNode.next = nil
            head = newNode
            tail = newNode
        }
    }
    
    /// Удаляет элемент из начала очереди
    ///  - Returns значение элемента
    func popFront() -> T? {
        if let headNode = head {
            if let nextNode = headNode.next {
                nextNode.previous = nil
                head = nextNode
            } else {
                head = nil
                tail = nil
            }
            return headNode.value
        } else {
            return nil
        }
    }
    
    /// Удаляет элемент с конца очереди
    ///  - Returns значение элемента
    func popBack() -> T? {
        if let tailNode = tail {
            if let previousNode = tailNode.previous {
                previousNode.next = nil
                tail = previousNode
            } else {
                head = nil
                tail = nil
            }
            return tailNode.value
        } else {
            return nil
        }
    }
    
    /// Проверяет пустая ли очередь
    func isEmpty() -> Bool {
        head != nil ? false : true
    }
}

//MARK: - Examples
/// Пример №3
enum Priority {
    case high, low
}

struct Product {
    var title: String
    var price: Double
    var priority: Priority {
        price >= 10000 ? .high : .low
    }
}

let factory = Deque<Product>()

let product1 = Product(title: "Quadrocopter", price: 5000)
let product2 = Product(title: "Quadrocopter-Top", price: 11000)
let product3 = Product(title: "Quadrocopter", price: 6000)
let product4 = Product(title: "Helicopter", price: 400000)
let product5 = Product(title: "Quadrocopter", price: 4000)

factory.add(value: product1, priority: product1.priority)
factory.add(value: product2, priority: product2.priority)
factory.add(value: product3, priority: product3.priority)
let finishedProduct1 = factory.popFront()

factory.add(value: product4, priority: product4.priority)
factory.add(value: product5, priority: product5.priority)
let finishedProduct2 = factory.popFront()
let finishedProduct3 = factory.popFront()
