//
//  ViewController.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 08.10.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    private let box = CustomView()
    
    @IBOutlet weak var customView: CustomView!
    
    @IBOutlet weak var customViewCenterYConstaint: NSLayoutConstraint!
    @IBOutlet weak var customViewCenterXConstaint: NSLayoutConstraint!
    let panGestureRecognizer = UIPanGestureRecognizer()
    let pinchGestureRecognizer = UIPinchGestureRecognizer()
    var panGestureAnchorPoint: CGPoint?
    var pinchGestureAnchorScale: CGFloat?
    
    private var scale: CGFloat = 1.0 { didSet { updateBoxTransform() } }
    private var rotation: CGFloat = 0.0 { didSet { updateBoxTransform() } }
    
    //    private var widthConstraint: NSLayoutConstraint!
    //    private var heightConstraint: NSLayoutConstraint!
    //    private var centerYConstraint: NSLayoutConstraint!
    //    private var centerXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupGestureRecognizer()
    }
    
    
    func updateBoxTransform() {
        customView.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale).rotated(by: rotation)
    }
    
    // --
    func setupGestureRecognizer() {
        panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        
        pinchGestureRecognizer.addTarget(self, action: #selector(handlePinchGesture(_:)))
        
        panGestureRecognizer.delegate = self
        pinchGestureRecognizer.delegate = self
        
        customView.addGestureRecognizer(panGestureRecognizer)
        customView.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    
    @objc func handlePinchGesture (_ gestureRecognizer: UIPinchGestureRecognizer) {
        
        guard pinchGestureRecognizer === gestureRecognizer else { assert(false); return }

        switch gestureRecognizer.state {
        case .began:
//            assert(pinchGestureAnchorScale == nil)
            pinchGestureAnchorScale = gestureRecognizer.scale

        case .changed:
            guard let pinchGestureAnchorScale = pinchGestureAnchorScale else { assert(false); return }

            let gestureScale = gestureRecognizer.scale
            scale += gestureScale - pinchGestureAnchorScale
            self.pinchGestureAnchorScale = gestureScale

        case .cancelled, .ended:
            pinchGestureAnchorScale = nil

        case .failed, .possible:
            break
        @unknown default:
            break
        }
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard panGestureRecognizer === gestureRecognizer else {
//            assert(false);
            return
        }
        
        switch gestureRecognizer.state {
            
        case .began:
            assert(panGestureAnchorPoint == nil)
            panGestureAnchorPoint = gestureRecognizer.location(in: customView)
            
            
        case .changed:
            guard let panGestureAnchorPoint = panGestureAnchorPoint else { assert(false); return }
            
            let gesturePoint = gestureRecognizer.location(in: customView)
            //            gesturePoint.x += gesturePoint.x - panGestureAnchorPoint.x
            //            gesturePoint.y += gesturePoint.y - panGestureAnchorPoint.y
            
//            let centerXConstraint = customView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            let centerYConstraint = customView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            customViewCenterXConstaint.constant += gesturePoint.x - panGestureAnchorPoint.x
            customViewCenterYConstaint.constant += gesturePoint.y - panGestureAnchorPoint.y
//            self.panGestureAnchorPoint = gesturePoint
            
        case .ended, .cancelled:
            panGestureAnchorPoint = nil
        case .possible, .failed:
            assert(panGestureAnchorPoint == nil)
            break
        @unknown default:
            assert(panGestureAnchorPoint == nil)
            break
        }
    }
}

extension FirstViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        let simultaneousRecognizers = [panGestureRecognizer, pinchGestureRecognizer]
        return simultaneousRecognizers.contains(gestureRecognizer) &&
               simultaneousRecognizers.contains(otherGestureRecognizer)
    }
}
