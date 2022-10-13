//
//  PaletteViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 12.10.2022.
//

import UIKit

final class PaletteViewController: UIViewController {
    
    @IBOutlet var colorViews: [UIView]!
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
        print(colorViews[0].frame.width)
    }
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(colorViews[0].frame.width)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        setupElements()
        super.viewDidAppear(animated)
        
        print(colorViews[0].frame.width)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "setupColor" else { return }
        guard let setupVC = segue.destination as? SetupColorViewController else { return }
        
        let gradient = Gradient(
            firstColor: getColor(tag: 0),
            secondColor: getColor(tag: 1),
            thirdColor: getColor(tag: 2),
            fourthColor: getColor(tag: 3)
        )
        setupVC.gradient = gradient
    }
    
    
    private func setupElements() {
        colorViews.forEach {
            let doubleTapGestureRecognizer = UITapGestureRecognizer()
            doubleTapGestureRecognizer.addTarget(self, action: #selector(handleDoubleTapGesture(_:)))
            doubleTapGestureRecognizer.numberOfTapsRequired = 2
            
            $0.layer.cornerRadius = $0.bounds.width / 2
            let color = UIColor(red: 102/255, green: 103/255, blue: 171/255, alpha: 1)
            $0.layer.borderColor = color.cgColor
            $0.layer.borderWidth = 2
            $0.addGestureRecognizer(doubleTapGestureRecognizer)
        }
    }
    
    private func getColor(tag: Int) -> UIColor {
        return colorViews.first{ $0.tag == tag }?.backgroundColor ?? .clear
    }
    
    @objc private func handleDoubleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let colorView = colorViews.first {
            $0.tag == gestureRecognizer.view?.tag
        }
        
        showColorAlert(color: colorView?.backgroundColor ?? .white) { color in
            colorView?.backgroundColor = color
        }
    }
    
    
}
