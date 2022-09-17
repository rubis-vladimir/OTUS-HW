
/// Создает произвольный словарь данных пользователей
///  - Parameter array: массив имен пользователей
///  - Returns: словарь [имя пользователя : пароль]
func createUserDataDictionary(_ array: [String]) -> [String: String] {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    return array.reduce(into: [String: String]()) { result, userName in
        let randomLenght = (6...20).randomElement()!
        let randomPassword = (0..<randomLenght).map{_ in String(letters.randomElement()!)}.joined()
        result[userName] = randomPassword
    }
}

let arrayNames = ["Vladimir", "Nikolay", "Kseniya", "Petr", "Milana", "Svetlana", "Lev"]
let userDict = createUserDataDictionary(arrayNames)

/// Массив имен пользователей, пароли которых >10 символов
let filterNames = userDict
    .filter{ $0.value.count > 10 }
    .keys
