//
//  SetupStarViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 13.10.2022.
//

import UIKit

final class SetupStarViewController: UIViewController {
    
    // MARK: - Properties & IBOutlets
    var star: Star?
    private let moduleTitle = "SetupStar"
    
    @IBOutlet weak var colorStarView: UIView!
    @IBOutlet weak var starRaysCountLabel: UILabel!
    @IBOutlet weak var multiInnerRadiusLabel: UILabel!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
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
    
    // MARK: - Navigations
    /// Переход и передача данных вперед
    @IBAction func previewButtonPressed(_ sender: Any) {
        
        /// Валидация введенных значений
        guard let raysString = starRaysCountLabel.text,
              let starRays = Int(raysString),
              let multiString = multiInnerRadiusLabel.text,
              let multi = Double(multiString),
              let color = colorStarView.backgroundColor,
              0...1.0 ~= multi
        else {
            showHelper(message: "1. Specify an integer number of star rayz \n2. Inner radius multiplier must be between 0 and 1")
            return }
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PreviewStarVC") as? PreviewStarViewController else { return }

        let star = Star(starRays: starRays,
                        multiRadius: CGFloat(multi),
                        color: color)
        vc.star = star
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - IBActions
    /// Настройка цвета звезды
    @IBAction func colorStarButtonPressed(_ sender: Any) {
        let colorStar = colorStarView.backgroundColor
        showColorAlert(color: colorStar ?? .white) { color in
            self.colorStarView.backgroundColor = color
        }
    }
    
    // MARK: - Private func
    /// Настраивает элементы
    private func setupElements() {
        guard let star = star else { return }
        colorStarView.backgroundColor = star.color
        starRaysCountLabel.text = String(star.starRays)
        multiInnerRadiusLabel.text = String(Float(star.multiRadius))
    }
}

// MARK: - UITextFieldDelegate
extension SetupStarViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            starRaysCountLabel.text = textField.text
        default:
            multiInnerRadiusLabel.text = textField.text
        }
    }
}
