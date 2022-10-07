//
//  PaddingLabel.swift
//  #16 Stopwatch
//
//  Created by Владимир Рубис on 07.10.2022.
//

import UIKit

/// Лэйбл с внутренними отступами
@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset,
                                  left: leftInset,
                                  bottom: bottomInset,
                                  right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
}
