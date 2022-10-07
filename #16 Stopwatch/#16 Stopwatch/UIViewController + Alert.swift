//
//  UIViewController + Alert.swift
//  #16 Stopwatch
//
//  Created by Владимир Рубис on 07.10.2022.
//

import UIKit

extension UIViewController {
    
    /// Показывает Алерт
    func showAlert(title: String,
                   message: String,
                   completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "RESET",
                                        style: .cancel) { _ in
            completion()
        }
        alert.addAction(resetAction)
        present(alert, animated: true)
    }
}
