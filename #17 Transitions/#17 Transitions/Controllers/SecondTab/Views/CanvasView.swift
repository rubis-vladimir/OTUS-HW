//
//  CanvasView.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 13.10.2022.
//

import UIKit

final class CanvasView: UIView {
    
    var star: Star?
    
    override func draw(_ rect: CGRect) {
        if let star = star {
            let patternPadding: CGFloat = 5
            let patternRadius: CGFloat = 5
            
            var x: CGFloat = patternPadding
            var y: CGFloat = patternPadding
            
            while y < rect.height {
                let pathRect = CGRect(x: x, y: y, width: patternRadius, height: patternRadius)
                
                let path = starIn(rect: pathRect, star: star)
                star.color.setFill()
                path.fill()
                
                x += patternRadius + patternPadding
                
                if x > rect.width {
                    x = patternPadding
                    y += patternRadius + patternPadding
                }
            }
        } else {
            super.draw(rect)
        }
    }
}
