//
//  ACCustomPopAnimation.swift
//  CustomModal
//
//  Created by AmberChin on 2017/7/24.
//  Copyright © 2017年 AmberChin. All rights reserved.
//

import UIKit

class ACCustomPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ACCustomSecondController
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ACCustomFirstController
        let selectedCell = toVc.collection.cellForItem(at: toVc.selectedIndex! as IndexPath) as! ACCollectionCell
        let snapImgView = fromVc.imgView.snapshotView(afterScreenUpdates: false)
        
        let duration = self.transitionDuration(using: transitionContext)
        let startFrame = fromVc.view.convert(fromVc.imgView.frame, to: containerView)
        let finalFrame = selectedCell.imgView.convert(selectedCell.imgView.frame, to: containerView)
        
        snapImgView?.frame = startFrame
        fromVc.imgView.isHidden = true
        toVc.view.alpha = 0
        
        containerView.insertSubview(toVc.view, belowSubview: fromVc.view)
        containerView.addSubview(snapImgView!)
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            toVc.view.alpha = 1
            fromVc.view.alpha = 0
            snapImgView?.frame = finalFrame
        }, completion: { (finished) -> Void in
            fromVc.imgView.isHidden = false
            selectedCell.imgView.isHidden = false
            snapImgView?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
