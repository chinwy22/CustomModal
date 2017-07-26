//
//  ACScaleNavigationController.swift
//  CustomModal
//
//  Created by AmberChin on 2017/7/21.
//  Copyright © 2017年 AmberChin. All rights reserved.
//

import UIKit

class ACScaleNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var interactivePopTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
        let popRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ACScaleNavigationController.handlePopRecognizer(_:)))
        popRecognizer.edges = .left;
        self.view.addGestureRecognizer(popRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == .push) {
            return ACPushTransition()
        } else if operation == .pop {
            return ACPopTransition()
        } else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactivePopTransition
    }
    
    func handlePopRecognizer(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        var progress = recognizer.translation(in: self.view).x / self.view.bounds.width
        progress = min(1.0, max(0.0, progress))
        
        if recognizer.state == .began {
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.popViewController(animated: true)
        } else if recognizer.state == .changed {
            interactivePopTransition?.update(progress)
        } else if recognizer.state == .ended || recognizer.state == .cancelled {
            if progress > 0.5 {
                interactivePopTransition?.finish()
            } else {
                interactivePopTransition?.cancel()
            }
            interactivePopTransition = nil
        }
    }
}
