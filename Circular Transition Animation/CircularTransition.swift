//
//  CircularTransition.swift
//  Circular Transition Animation
//
//  Created by mohit kotie on 09/12/17.
//  Copyright © 2017 mohit kotie mohit. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    
var circle = UIView()

    var startingPoint = CGPoint.zero{
        didSet{
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 0.3
    enum CircularTransitionMode:Int{
        case present, dismiss, pop
    }
    var transitionMode:CircularTransitionMode = .present
}

extension CircularTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        if transitionMode == .present{
            
            if let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentView.center
                let viewSize = presentView.frame.size
                
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startingPoint: startingPoint)
//circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startingPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentView.center = startingPoint
                presentView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentView.alpha = 0
                containerView.addSubview(presentView)
                
                UIView.animate(withDuration: duration,animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentView.transform = CGAffineTransform.identity
                    presentView.alpha = 1
                    presentView.center = viewCenter
                    
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
            
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey){
                
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startingPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration,animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop{
                        
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
               
                
            }
            
        }
        
    }
    
    func frameForCircle(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startingPoint:CGPoint) -> CGRect {
        
        let xLength = fmax(startingPoint.x, viewSize.width - startingPoint.x)
        let yLength = fmax(startingPoint.y, viewSize.width - startingPoint.y)
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 4
        let size = CGSize(width: offsetVector, height: offsetVector)
        return CGRect(origin: CGPoint.zero, size: size)

        
    }
    
    
}
