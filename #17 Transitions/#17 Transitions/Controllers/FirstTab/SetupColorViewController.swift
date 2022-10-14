//
//  SetupColorViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 12.10.2022.
//

import UIKit

final class SetupColorViewController: UIViewController {
    
    // MARK: - Properties & IBOutlets
    var gradient: Gradient?
    private let moduleTitle = "SetupColor"
    
    @IBOutlet var colorViews: [UIView]!
    @IBOutlet var colorSwitches: [UISwitch]!
    @IBOutlet weak var setGradientButton: UIButton!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        setColors()
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
    
    // MARK: - IBActions
    @IBAction func disableColorSwitchChange(_ sender: UISwitch) {
        changeState(sender)
    }
    
    // MARK: - Private func
    /// Изменяет состояние цвета (some/none) по tag
    private func changeState(_ colorSwitch: UISwitch) {
        let color = colorSwitch.isOn ? colorViews.first { $0.tag == colorSwitch.tag }?.backgroundColor : nil
        
        switch colorSwitch.tag {
        case 0:
            gradient?.firstColor = color
        case 1:
            gradient?.secondColor = color
        case 2:
            gradient?.thirdColor = color
        default:
            gradient?.fourthColor = color
        }
    }
    
    /// Установка цветов вью из цветов градиента
    private func setColors() {
        guard let gradient = gradient else { return }
        colorViews.first { $0.tag == 0 }?.backgroundColor = gradient.firstColor
        colorViews.first { $0.tag == 1 }?.backgroundColor = gradient.secondColor
        colorViews.first { $0.tag == 2 }?.backgroundColor = gradient.thirdColor
        colorViews.first { $0.tag == 3 }?.backgroundColor = gradient.fourthColor
    }
}
