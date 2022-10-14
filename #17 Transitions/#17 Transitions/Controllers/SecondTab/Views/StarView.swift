//
//  StarView.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 13.10.2022.
//

import UIKit

final class StarView: UIView {
    
    var star: Star? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let star = star else { return }
        let path = starIn(rect: rect, star: star)
        star.color.setFill()
        path.fill()
    }
}
