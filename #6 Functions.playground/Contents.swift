import UIKit

//1 Функция складывает две целочисленных переменных - отдает на выходе сумму
//2 Функция принимает кортеж из числа и строки приводит число к строке и ввыводит в консоль резуультат
//3 Функция принимает на вход опциональное замыкание и целое число, выполняет замыкание только. в случае если число больше 0
//4 Функция принимает число на вход (год), проверить високосный ли он

/// #1 Summ
func summ(_ x: Int, _ y: Int) -> Int { x + y }

/// #2 TupleToString
func getString(_ tuple: (Int, String)) {
    print(String(tuple.0) + " " + tuple.1)
}

/// #3 CheckAndPlayClosure
typealias Closure = (() -> ())?
func checkAndPlay(_ number: Int, completion: Closure) {
    guard number > 0 else { return }
    guard let completion = completion else { return }
    completion()
}

/// #4 IsLeapYear
func isLeapYear(_ year: Int) -> Bool {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0
}
