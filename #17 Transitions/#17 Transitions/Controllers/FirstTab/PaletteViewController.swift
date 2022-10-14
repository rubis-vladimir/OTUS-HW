//
//  PaletteViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 12.10.2022.
//

import UIKit

final class PaletteViewController: UIViewController {
    
    // MARK: - Properties & IBOutlets
    private let moduleTitle = "PaletteView"
    
    @IBOutlet var colorViews: [UIView]!
    
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
        setupElements()
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
    /// #Переход и передача данных вперед
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
    
    // MARK: - IBActions
    @IBAction func helpButtonPressed(_ sender: Any) {
        showHelper(message: "Double click on the view \nto adjust the color")
    }
    
    // MARK: - Private func
    /// Настраивает элементы
    private func setupElements() {
        colorViews.forEach {
            /// Добавление ивента при двойном нажатии
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
    
    /// Получает цвет из view по tag
    private func getColor(tag: Int) -> UIColor {
        return colorViews.first{ $0.tag == tag }?.backgroundColor ?? .clear
    }
    
    /// При двойном нажатии вызывает алерт для установки цвета
    @objc private func handleDoubleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let colorView = colorViews.first {
            $0.tag == gestureRecognizer.view?.tag
        }
        showColorAlert(color: colorView?.backgroundColor ?? .white) { color in
            colorView?.backgroundColor = color
        }
    }
}
