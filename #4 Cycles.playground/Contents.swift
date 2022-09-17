import Foundation

/// Создает произвольный массив целых чисел от -100 до 100
///  - Parameter num: количество числе в массиве
///  - Returns: массив чисел
func createRandomArray(_ num: Int) -> [Int] {
    return (0..<num).map{ _ in .random(in: -100...100) }
}

/// Получает индекс первого повторяющегося числа в массиве
///  - Parameter array: массив
///  - Returns: индекс
func getFirstRepeatIndex(from array: [Int]) -> Int {
    return array.enumerated()
        .first {
            array.dropFirst($0.0 + 1).contains($0.1) ? true : false
        }?.offset ?? -1
}

let randomArray = createRandomArray(20)
let firstIndexRepeat = getFirstRepeatIndex(from: randomArray)
