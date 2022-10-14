//
//  GradientViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 12.10.2022.
//

import UIKit

class GradientViewController: UIViewController {
    
    //MARK: - Properties & IBOutlets
    private let defaultColor = UIColor(red: 241/255, green: 240/255, blue: 236/255, alpha: 1)
    private let moduleTitle = "GradientView"
    
    @IBOutlet weak var setupColorButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    
    //MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        print(moduleTitle + Log.didLoad.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(moduleTitle + Log.willAppear.rawValue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(moduleTitle + Log.didAppear.rawValue)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print(moduleTitle + Log.destroy.rawValue)
        }
    }
    
    deinit {
        print(moduleTitle + Log.deinitModule.rawValue)
    }
    
    //MARK: - Navigation
    /// Переход и передача данных через unwind
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        guard let setupVC = segue.source as? SetupColorViewController else { return }
        guard let gradient = setupVC.gradient else { return }
        setupColorView(with: gradient)
    }
    
    //MARK: - Private func
    /// Настраивает цвет вью в зависимости от установленных цветов в градиенте
    private func setupColorView(with gradient: Gradient) {
        let layer = gradient.getGradientLayer()
        guard let colors = layer.colors else { return }
        
        gradientView.layer.sublayers = nil
        
        if colors.count > 1 {
            layer.frame = gradientView.bounds
            gradientView.layer.addSublayer(layer)
        } else {
            if let color = gradient.getOneColor() {
                gradientView.backgroundColor = color
            } else {
                gradientView.backgroundColor = defaultColor
            }
        }
    }
}
