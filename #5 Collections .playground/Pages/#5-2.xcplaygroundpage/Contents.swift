
/// Создает произвольный массив символов
///  - Parameter num: количество символов в массиве
///  - Returns: массив символов
func createRandomArray(_ num: Int) -> [String] {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return (0..<num).map{ _ in String(letters.randomElement()!) }
}

let array1 = createRandomArray(10)
let array2 = createRandomArray(15)

/// Результирующее множество одинаковых элементов в массивах
var resultSet = Set(array1.filter{ array2.contains($0) })


