import Foundation

//MARK: Дженерик-класс для Стэк. Принцип LIFO. (Через массив - О(1))
final class Stack<T> {
    private var elements: [T] = []
    
    func push(value:T) {
        elements.append(value)
    }
    
    func pop() -> T? {
        guard let last = elements.last else { return nil }
        elements.removeLast()
        return last
    }
}

//MARK: - Examples
/// Пример №4
let stack = Stack<Int>()
stack.push(value: 10)
stack.push(value: 7)
stack.push(value: 3)
stack.push(value: 8)
let element = stack.pop()
