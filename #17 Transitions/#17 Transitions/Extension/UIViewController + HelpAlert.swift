//
//  UIViewController + HelpAlert.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 14.10.2022.
//
import UIKit

extension UIViewController {
    
    func showHelper(message: String) {
        let alert = UIAlertController(title: "Helper",
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
