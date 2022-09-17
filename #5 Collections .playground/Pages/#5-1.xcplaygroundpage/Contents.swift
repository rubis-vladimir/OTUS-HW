
/// Создает произвольный массив целых чисел от 0 до 100
///  - Parameter num: количество числе в массиве
///  - Returns: массив чисел
func createRandomArray(_ num: Int) -> [Int] {
    return (0..<num).map{ _ in .random(in: 0...100) }
}

/// Меняет местами max и min значения в массиве
///  - Parameter array: Массив элементов типа Т
///  - Returns: измененный массив
func change<T: Comparable & Numeric>(array: [T]) -> [T]? {
    guard let min = array.min(),
          let max = array.max(),
          let minIndex = array.firstIndex(of: min),
          let maxIndex = array.firstIndex(of: max) else { return nil }
    var newArray = array
    newArray[minIndex] = max
    newArray[maxIndex] = min
    return newArray
}

let randomArray = createRandomArray(10)
let changeArray = change(array: randomArray)


