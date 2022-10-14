//
//  CanvasStarsViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 14.10.2022.
//

import UIKit

final class CanvasStarsViewController: UIViewController {
    
    // MARK: - Properties & IBOutlets
    private let moduleTitle = "CanvasStars"
    
    @IBOutlet weak var canvasStarsView: CanvasView!
    
    // MARK: - Override func
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
    
    // MARK: - Navigations
    /// Переход и передача данных вперед
    @IBAction func setupCanvasButtonPressed(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SetupStarVC") as? SetupStarViewController else { return }
        vc.star = canvasStarsView.star
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
