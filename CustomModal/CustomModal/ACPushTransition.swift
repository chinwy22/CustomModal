//
//  ACPushTransition.swift
//  CustomModal
//
//  Created by AmberChin on 2017/7/21.
//  Copyright © 2017年 AmberChin. All rights reserved.
//

import UIKit

class ACPushTransition: NSObject , UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.view(forKey: .from)
        let toVC = transitionContext.view(forKey: .to)
        let duration = self.transitionDuration(using: transitionContext) //根据另一协议方法获取过场时间
        let containerView = transitionContext.containerView //过场容器视图
        containerView.addSubview(toVC!) //默认fromVC的视图已经添加
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        toVC?.frame = CGRect(x: screenW, y: 0, width: screenW, height: screenH)
//        开始动画啦
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0
        containerView.insertSubview(blackView, belowSubview: toVC!)
        UIView.animate(withDuration: duration, animations: {
            // shadows
            toVC?.layer.shadowOffset = CGSize(width: -3, height: 0)
            toVC?.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
            toVC?.layer.shadowOpacity = 1
            blackView.alpha = 0.7
            fromVC?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)// fromVc视图的scale设置到0.7
            toVC?.frame = CGRect(x: 0, y: 0, width: screenW, height: screenH)// toVc视图从屏幕右方移动到屏幕中间
            
        }) { (_) in
            //在动画结束时，必须调用transitionContext.completeTransition(!transitionContext.transitionWasCancelled())来清理舞台，如果传入一个true好像也没有问题，但是在加入右划返回手势，滑动一半取消时，就会出现问题，因此需要根据过场是否被取消来正确清理过场上下文
            blackView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
