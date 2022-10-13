//
//  Gradient.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 13.10.2022.
//

import UIKit

struct Gradient {
    var firstColor: UIColor?
    var secondColor: UIColor?
    var thirdColor: UIColor?
    var fourthColor: UIColor?
    
    
    func getGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        
        let arrayColors = [
            firstColor?.cgColor,
            secondColor?.cgColor,
            thirdColor?.cgColor,
            fourthColor?.cgColor,
        ].compactMap{$0}.filter { $0 != UIColor.clear.cgColor }
        
        let startColor = UIColor(red: 241, green: 240, blue: 236, alpha: 1)
        gradient.colors = arrayColors.isEmpty ? [startColor.cgColor] : arrayColors
        
        switch arrayColors.count {
        case 4:
            gradient.locations = [0, 0.25, 0.75, 1]
        case 3:
            gradient.locations = [0, 0.5, 1]
        case 2:
            gradient.locations = [0, 1]
        default: break
        }
        
        return gradient
    }
}
