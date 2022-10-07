//
//  SceneDelegate.swift
//  #16 Stopwatch
//
//  Created by Владимир Рубис on 07.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneDidBecomeActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: Notification.Name("StartStopTimer"), object: nil)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: Notification.Name("StartStopTimer"), object: nil)
    }
}

