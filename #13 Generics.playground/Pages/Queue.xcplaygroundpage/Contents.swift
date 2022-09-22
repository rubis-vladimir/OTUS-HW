import Foundation

//MARK: Однонаправленный связанный список
final class QueueNode<T> {
    var value: T
    var next: QueueNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

//MARK: Дженерик-класс для Очереди. Принцип FIFO
final class Queue<T> {
    /// Последний элемент очереди
    private var tail: QueueNode<T>?
    /// Первый элемент очереди
    private var head: QueueNode<T>?
    
    /// Удаляет элемент из начала очереди
    ///  - Returns элемент 
    func dequeue() -> QueueNode<T>? {
        if let headNode = head {
            head = headNode.next
            return headNode
        } else {
            return nil
        }
    }
    
    /// Добавляет элемент в конец очереди
    ///  - Parameter value: значение элемента
    func enqueue(value: T) {
        let newNode = QueueNode(value: value)
        
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.next = nil
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }
}

//MARK: Реализуем протокол Sequence
extension Queue: Sequence {
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator(current: head)
    }
}

//MARK: Определяем Итератор
struct QueueIterator<T>: IteratorProtocol {
    var current: QueueNode<T>?
    
    mutating func next() -> T? {
        if let currentNode = current {
            let element = currentNode.value
            current = currentNode.next
            return element
        } else {
            return nil
        }
    }
}

//MARK: - Examples
/// Пример №1
typealias Closure = ()->()
let task1 = { print("Гордость") }
let task2 = { print("Смелость") }
let queue = Queue<Closure>()

queue.enqueue(value: task1)
queue.enqueue(value: task2)
queue.dequeue()?.value()

/// Пример №2
let queueFullName = Queue<String>()
queueFullName.enqueue(value: "Петров Иван")
queueFullName.enqueue(value: "Сидоров Константин")
queueFullName.enqueue(value: "Козлов Иван")
queueFullName.enqueue(value: "Петухова Анна")

queueFullName.contains("Петров Иван")
queueFullName.filter{$0.contains("Пет")}
    .forEach { print($0) }



