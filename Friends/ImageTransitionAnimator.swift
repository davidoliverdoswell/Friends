//
//  ImageTransitionAnimator.swift
//  Friends
//
//  Created by David Doswell on 1/17/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

protocol LabelProviding {
    var label: UILabel! { get }
    var image: UIImageView! { get }
}

typealias LabelProvidingVC = LabelProviding & UIViewController

class ImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? LabelProviding,
            let toVC = transitionContext.viewController(forKey: .to) as? LabelProviding,
            let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        let sourceLabel = fromVC.label!
        sourceLabel.alpha = 0.0
        let sourceView = fromVC.image!
        sourceView.alpha = 0.0
        containerView.addSubview(sourceLabel)
        containerView.addSubview(sourceView)
        
        let destinationLabel = toVC.label!
        destinationLabel.alpha = 0.0
        let destinationView = toVC.image!
        destinationView.alpha = 0.0
        containerView.addSubview(destinationLabel)
        containerView.addSubview(destinationView)
        
        // set initial label frame and image in container view
        let labelInitialFrame = containerView.convert(sourceLabel.bounds, from: sourceLabel)
        let imageInitialFrame = containerView.convert(sourceView.bounds, from: sourceView)
        
        let animatedLabel = UILabel(frame: labelInitialFrame)
        animatedLabel.text = sourceLabel.text
        animatedLabel.font = sourceLabel.font
        animatedLabel.sizeToFit()
        containerView.addSubview(animatedLabel)
        
        let animatedImage = UIImageView(frame: imageInitialFrame)
        animatedImage.contentMode = .scaleAspectFill
        containerView.addSubview(animatedImage)
        
        let duration = transitionDuration(using: transitionContext)
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            animatedLabel.frame = containerView.convert(destinationLabel.bounds, from: destinationLabel)
            animatedImage.frame = containerView.convert(destinationView.bounds, from: destinationView)
            toView.alpha = 1.0
        }) { (success) in
            
            sourceLabel.alpha = 1.0
            sourceView.alpha = 1.0
            destinationLabel.alpha = 1.0
            destinationView.alpha = 1.0
            
            animatedLabel.removeFromSuperview()
            animatedImage.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
}
