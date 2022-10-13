//
//  SetupColorViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 12.10.2022.
//

import UIKit

class SetupColorViewController: UIViewController {
    var gradient: Gradient?
    
    @IBOutlet var colorViews: [UIView]!
    @IBOutlet var colorSwitches: [UISwitch]!
    @IBOutlet weak var setGradientButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setColors()
    }
    
    @IBAction func disableColorSwitchChange(_ sender: UISwitch) {
        changeState(sender)
    }
    
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
    
    private func setColors() {
        guard let gradient = gradient else { return }
        colorViews.first { $0.tag == 0 }?.backgroundColor = gradient.firstColor
        colorViews.first { $0.tag == 1 }?.backgroundColor = gradient.secondColor
        colorViews.first { $0.tag == 2 }?.backgroundColor = gradient.thirdColor
        colorViews.first { $0.tag == 3 }?.backgroundColor = gradient.fourthColor
    }
}
