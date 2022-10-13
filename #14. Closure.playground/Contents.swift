import UIKit

//1 Функция, принимающая функцию как параметр
//2 Функция с несколькими замыканиями
//3 Функция с autoclosure
//4 Использование внутренних функций
//5 Дженерик-функция с условием

///  #1 Cooking (Функция как параметр)
typealias Method = ((TypeOfCooking, String)) -> (String)

enum TypeOfCooking: String {
    case fry = "Жареная"
    case steam = "Пареная"
    case dry = "Вяленая"
}

func useCookingMethod(_ method: TypeOfCooking,
                      for dish: String) -> String {
    return "\(method.rawValue) \(dish)"
}

func cook(main: String,
          garnish: String,
          method: TypeOfCooking,
          cooking: Method) -> String {
    let dish =  main + " и " + garnish
    return cooking((method, dish))
}

// Пример
let dish1 = cook(main: "рыба", garnish: "рис", method: .steam, cooking: useCookingMethod)
let dish2 = cook(main: "говядина", garnish: "овощи", method: .fry, cooking: useCookingMethod)


/// #2 Convert number (Несколько замыканий)
var descendingOrder: (Int) -> Int = { number in
    let sortedString = number
        .description
        .sorted(by: >)
        .map(String.init)
        .joined()
    
    return Int(sortedString) ?? number
}

func convertMulti(number: Int,
                  conversionMethod: (Int) -> Int,
                  completion: (Int) -> ()) {
    completion(conversionMethod(number * number))
}

// Пример
convertMulti(number: 1782, conversionMethod: descendingOrder) {
    print($0)
}

/// #3 Пирамида (Автозамыкание)
func pyramid(_ building: @autoclosure () -> Void) {
    building()
}

// Пример
pyramid(print((0..<5).map { Array(repeating: 1, count: $0 + 1) }))


/// #4 Min Perimetr (Внутренняя функция)
func minimumPerimeter(_ areaString: String) -> Int? {
    
    func convertAndClear(from: String) -> Int? {
        let numberString = "1234567890"
        return Int(from.filter{ numberString.contains($0) })
    }
    
    guard let area = convertAndClear(from: areaString) else { return nil }
    var width = Int(sqrt(Double(area)))
    while area % width != 0 {
        width -= 1
    }
    return width * 2 + area / width * 2
}

Result

// Пример
minimumPerimeter("Площадь-45*")


/// #5 Output values by index (even/uneven) (Дженерик с условием)
enum Index: Int {
    case even = 0
    case uneven = 1
}

func outputValues<T>(by: Index, from: T)  where T: Collection {
    let array = from.map{$0}
    let strideArray = stride(from: by.rawValue, to: array.count, by: 2).map{array[$0]}
    print(strideArray)
}

// Пример
var array = [1, 4, 5, 7, 8, 15, 25, 38, 45]
outputValues(by: .even, from: array)

/// PS. с Set значения будут в рандомном порядке
