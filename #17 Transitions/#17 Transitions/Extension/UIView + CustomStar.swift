//
//  UIView + CustomStar.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 13.10.2022.
//

import UIKit

extension UIView {
    
    /// Отрисовывает контур(путь) звезды
    ///  - Parameters:
    ///   - rect: прямоугольник в который вписывыем
    ///   - star: модель звезды
    ///  - Returns: созданный путь путь
    func starIn(rect: CGRect,
                star: Star) -> UIBezierPath {
        let path = UIBezierPath()
        let center = CGPoint(x: rect.origin.x + rect.width / 2.0, y: rect.origin.y + rect.height / 2.0)
                
        let pointsOnStar = star.starRays
                
        var angle: CGFloat = CGFloat(CGFloat.pi / 2.0)
        let angleIncrement = CGFloat(Double.pi * 2.0 / Double(pointsOnStar))
        let radius: CGFloat = rect.width / 2.0
        let midRadius: CGFloat = star.multiRadius * radius
                
        var firstPoint = true
        
        for _ in 1...pointsOnStar {
           let point = pointFrom(angle: angle, radius: midRadius, offset: center)
           let nextPoint = pointFrom(angle: angle + angleIncrement, radius: midRadius, offset: center)
           let midPoint = pointFrom(angle: angle + angleIncrement / 2.0, radius: radius, offset: center)
           
           if firstPoint {
              firstPoint = false
              path.move(to: point)
           }
            
           path.addLine(to: midPoint)
           path.addLine(to: nextPoint)
           
           angle += angleIncrement
        }
        path.close()
        
        return path
    }
    
    /// Определяет точку
    ///  - Parameters:
    ///   - angle: угол
    ///   - radius: радиус
    ///   - offset: смещиние
    ///  - Returns: точку
    private func pointFrom(angle: CGFloat,
                           radius: CGFloat,
                           offset: CGPoint) -> CGPoint {
       let x = radius * cos(angle) + offset.x
       let y = radius * sin(angle) + offset.y
            
       return CGPoint(x: x, y: y)
    }
}
