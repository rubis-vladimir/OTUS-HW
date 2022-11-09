import UIKit

func exploreCode(firstQueue: DispatchQueue = .main,
                 secondQueue: DispatchQueue = DispatchQueue.global(qos: .background)) {
    print("1")
    firstQueue.async {
        print("2")
        secondQueue.sync { /// #1
            print("3")
            firstQueue.sync { /// #2
                print("4")
                secondQueue.async { /// #3
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    print("9")
}

// 1. Исследование I
exploreCode()

/// Результат: 1 9 2 3, последовательность такая:
/// Печатаем 1, далее в `.main` очередь `асинхронно` добавляем задачу и просим у системы вернуть контроль над кодом, чтобы не ждать. Поэтому после 1 тут же напечатается 9. Далее переходим к поставленной в очередь `асинхронно` к `.main` задаче. Первым делом напечатается 2, а потом мы `синхронно`  к `.main` добавляем задачу в `.global(qos: .background)` очередь, а следовательно ``блокируем`` `.main` и выполняем код внутри - печатаем 3. Затем `синхронно`  к `.global(qos: .background)` добавляем задачу в `.main` и получаем ``взаимную блокировку - deadlock`` (одна очередь держит другую и наоборот)

// 2 CustomQueue
let customSerialQueue = DispatchQueue(label: "customSerial")
let customConcurrentQueue = DispatchQueue(label: "customConcurrent",
                                          qos: .userInteractive,
                                          attributes: [.concurrent])
// 2.1 Исследование II
//exploreCode(firstQueue: customSerialQueue)

// 2.2 Исследование III
//exploreCode(secondQueue: customConcurrentQueue)

/// Результат: в случае II - 1 2 3 9,  в случае III - 1 9 2 3
/// В случае III - ситуация такая же, как и в I, так как очередь (secondQueue) отличается лишь приоритетом
/// В случае II - разница в том, что мы `асинхронно` к `.main` ставим задачу в другую серийную очередь, которая работает на своем потоке, и тут вывод зависит от того какой из потоков быстрее обработает свою задачу
/* При этом все равно возникнет deadlock
 firstQueue.async {
    secondQueue.sync {
        firstQueue.sync {
        }
    }
 }
*/

// 3 Если поменять sync #1 или #2 c async #3 местами(смотри в функции exploreCode) deadlock не произойдет

// 4 Из concurrent в serial:

let semaphore = DispatchSemaphore(value: 0)

func exploreCode2() {
    print("1")
    DispatchQueue.main.async {
        print("2")
        semaphore.signal()
        DispatchQueue.global(qos: .background).sync {
            print("3")
            DispatchQueue.main.sync {
                print("4")
                DispatchQueue.global(qos: .background).async {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
        semaphore.wait()
    }
    print("9")
}

exploreCode2()

/// Результат: Пропуская очередное упоминание deadlock, мы можем ограничить количество потоков, которые могут одновременно обращаться к очереди с помощью Semaphore. Если это количество равно 1, то concurrentQueue работает, как serialQueue.
