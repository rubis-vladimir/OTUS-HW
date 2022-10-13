//
//  GradientViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 12.10.2022.
//

import UIKit



class GradientViewController: UIViewController {
    
    @IBOutlet weak var setupColorButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    
    //    private lazy var gradient: CAGradientLayer = {
    //        let gradient = CAGradientLayer()
    //        gradient.type = .axial
    //        gradient.colors = [
    //            UIColor.red.cgColor,
    //            UIColor.white.cgColor,
    //            UIColor.cyan.cgColor
    //        ]
    //        gradient.locations = [0, 0.25, 1]
    //        return gradient
    //    }()
    //
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        gradient.frame = view.bounds
        //        gradientView.layer.addSublayer(gradient)
        
        setupColorButton.titleLabel?.textAlignment = .center
        setupColorButton.layer.cornerRadius = 20
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        guard let setupVC = segue.source as? SetupColorViewController else { return }
        guard let gradientLayer = setupVC.gradient?.getGradientLayer() else { return }
        setupGradient(with: gradientLayer)
    }
    
    private func setupGradient(with layer: CAGradientLayer) {
        
        
        guard let colors = layer.colors else { return }
        if colors.count > 1 {
            layer.frame = gradientView.bounds
            gradientView.layer.addSublayer(layer)
        } else {
            
            
        }
        
    }
    
    
}
