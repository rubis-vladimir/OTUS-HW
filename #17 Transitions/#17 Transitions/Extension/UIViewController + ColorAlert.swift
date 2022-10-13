//
//  UIViewController + ColorAlert.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 12.10.2022.
//

import UIKit

extension UIViewController {
    
    func showColorAlert(color: UIColor,
                        completion: @escaping (UIColor) -> ()) {
        let ciColor = CIColor(color: color)
        
        let alert = UIAlertController(title: nil,
                                      message: "\n\n\n\n\n\n",
                                      preferredStyle: .alert)
        
        let generalStack = UIStackView()
        let titleLabel = UILabel()
        let redSlider = UISlider()
        let greenSlider = UISlider()
        let blueSlider = UISlider()
        
        generalStack.addArrangedSubview(titleLabel)
        
        generalStack.addArrangedSubview(
            addColorStack(with: Float(ciColor.red),
                          slider: redSlider,
                          title: "Red")
        )
        generalStack.addArrangedSubview(
            addColorStack(with: Float(ciColor.green),
                          slider: greenSlider,
                          title: "Green")
        )
        generalStack.addArrangedSubview(
            addColorStack(with: Float(ciColor.blue),
                          slider: blueSlider,
                          title: "Blue")
        )
        
        titleLabel.text = "Set color"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        
        generalStack.spacing = 10
        generalStack.axis = .vertical
        generalStack.translatesAutoresizingMaskIntoConstraints = false
        
        alert.view.addSubview(generalStack)
        NSLayoutConstraint.activate([
            generalStack.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20),
            generalStack.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            generalStack.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 20)
        ])
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let color = UIColor(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1
            )
            completion(color)
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func addColorStack(with value: Float,
                               slider: UISlider,
                               title: String) -> UIStackView {
        let stackView = UIStackView()
        let titleLabel = UILabel()
        let valueLabel = UILabel()
        let font = UIFont(name: "Helvetica", size: 20)
        
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.text = String(format: "%.2f", value)
        valueLabel.font = font
        
        slider.value = value
        slider.addAction(UIAction(handler: { _ in
            valueLabel.text = String(format: "%.2f", slider.value)
        }), for: .valueChanged)
        
        stackView.spacing = 15
        
        [titleLabel, slider, valueLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        titleLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return stackView
    }
}
