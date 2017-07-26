//
//  ACPopTransition.swift
//  CustomModal
//
//  Created by AmberChin on 2017/7/21.
//  Copyright © 2017年 AmberChin. All rights reserved.
//

import UIKit

class ACPopTransition: NSObject , UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.view(forKey: .from)
        let toVC = transitionContext.view(forKey: .to)
        let duration = self.transitionDuration(using: transitionContext) //根据另一协议方法获取过场时间
        let containerView = transitionContext.containerView //过场容器视图
        containerView.addSubview(toVC!) //默认fromVC的视图已经添加
        containerView.sendSubview(toBack: toVC!)
        
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0.7
        containerView.insertSubview(blackView, belowSubview: toVC!)
        
        UIView.animate(withDuration: duration, animations: {
            
            blackView.alpha = 0
            toVC?.transform = CGAffineTransform.init(scaleX: 1, y: 1)// fromVc视图的scale设置到0.7
            fromVC?.frame = CGRect(x: screenW, y: 0, width: screenW, height: screenH)
            
        }) { (_) in
            //在动画结束时，必须调用transitionContext.completeTransition(!transitionContext.transitionWasCancelled())来清理舞台，如果传入一个true好像也没有问题，但是在加入右划返回手势，滑动一半取消时，就会出现问题，因此需要根据过场是否被取消来正确清理过场上下文
            blackView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
