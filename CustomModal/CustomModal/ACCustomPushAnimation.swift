//
//  ACCustomPushAnimation.swift
//  CustomModal
//
//  Created by AmberChin on 2017/7/24.
//  Copyright © 2017年 AmberChin. All rights reserved.
//

import UIKit

class ACCustomPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ACCustomFirstController
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ACCustomSecondController
        let cell = fromVc.collection.cellForItem(at: (fromVc.collection.indexPathsForSelectedItems?.first)!) as! ACCollectionCell
        let snapImageView = cell.imgView.snapshotView(afterScreenUpdates: false)
        
        let duration = self.transitionDuration(using: transitionContext)
        let startFrame = cell.imgView.superview!.convert(cell.imgView.frame, to: containerView)
        let finalFrame = toVc.view.convert(toVc.imgView.frame, to: containerView)
        
        containerView.addSubview(toVc.view)
        containerView.addSubview(snapImageView!)
        
        snapImageView?.frame = startFrame
        cell.imgView.isHidden = true
        toVc.view.alpha = 0
        toVc.imgView.isHidden = true
        
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            toVc.view.alpha = 1
            snapImageView?.frame = finalFrame
        }, completion: { (finished) -> Void in
            toVc.imgView.isHidden = false
            cell.isHidden = false
            snapImageView?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
