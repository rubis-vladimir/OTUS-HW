//
//  PreviewStarViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 13.10.2022.
//

import UIKit

final class PreviewStarViewController: UIViewController {

    // MARK: - Properties & IBOutlets
    var star: Star?
    private let moduleTitle = "PreviewStar"
    
    @IBOutlet weak var starView: StarView!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        drawStar()
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
    /// На стартовый экран вкладки через popToRoot
    @IBAction func setCanvasButtonPressed(_ sender: Any) {
        guard let vc = self.navigationController?.viewControllers.first as? CanvasStarsViewController else { return }
        vc.canvasStarsView.star = star
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Private func
    /// Перерисовывает view со звездой
    private func drawStar() {
        guard let star = star else { return }
        starView.star = star
    }
}
