//
//  ImageTransitionAnimator.swift
//  Friends
//
//  Created by David Doswell on 1/17/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

protocol FriendProviding {
    var image: UIImageView! { get }
    var label: UILabel! { get }
    var bio: UILabel! { get }
}

typealias FriendProvidingVC = FriendProviding & UIViewController

class ImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? FriendProviding,
            let toVC = transitionContext.viewController(forKey: .to) as? FriendProviding,
            let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        // view
        let sourceView = fromVC.image!
        sourceView.alpha = 0.0
        
        // label
        let sourceLabel = fromVC.label!
        sourceLabel.alpha = 0.0
        
        // bio
        let sourceBioLabel = fromVC.bio!
        sourceBioLabel.alpha = 0.0

        containerView.addSubview(sourceView)
        containerView.addSubview(sourceLabel)
        containerView.addSubview(sourceBioLabel)
        
        let destinationView = toVC.image!
        destinationView.alpha = 0.0
        
        let destinationLabel = toVC.label!
        destinationLabel.alpha = 0.0
        
        let destinationBioLabel = toVC.bio!
        destinationBioLabel.alpha = 0.0

        containerView.addSubview(destinationBioLabel)
        containerView.addSubview(destinationLabel)
        containerView.addSubview(destinationView)
        
        // set initial image, label, and bio frames in container view
        let imageInitialFrame = containerView.convert(sourceView.bounds, from: sourceView)
        let labelInitialFrame = containerView.convert(sourceLabel.bounds, from: sourceLabel)
        let bioInitialFrame = containerView.convert(sourceBioLabel.bounds, from: sourceBioLabel)

        let animatedImage = UIImageView(frame: imageInitialFrame)
        animatedImage.contentMode = .scaleAspectFill
        containerView.addSubview(animatedImage)
        
        let animatedLabel = UILabel(frame: labelInitialFrame)
        animatedLabel.text = sourceLabel.text
        animatedLabel.font = sourceLabel.font
        animatedLabel.sizeToFit()
        containerView.addSubview(animatedLabel)
        
        let animatedBioLabel = UILabel(frame: bioInitialFrame)
        animatedBioLabel.text = sourceLabel.text
        animatedBioLabel.font = sourceLabel.font
        animatedBioLabel.sizeToFit()
        containerView.addSubview(animatedBioLabel)
        
        let duration = transitionDuration(using: transitionContext)
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            animatedImage.frame = containerView.convert(destinationView.bounds, from: destinationView)
            animatedLabel.frame = containerView.convert(destinationLabel.bounds, from: destinationLabel)
            animatedBioLabel.frame = containerView.convert(destinationBioLabel.bounds, from: destinationBioLabel)
            toView.alpha = 1.0
        }) { (success) in

            sourceView.alpha = 1.0
            sourceLabel.alpha = 1.0
            sourceBioLabel.alpha = 1.0

            destinationView.alpha = 1.0
            destinationLabel.alpha = 1.0
            destinationBioLabel.alpha = 1.0
            
            animatedImage.removeFromSuperview()
            animatedLabel.removeFromSuperview()
            animatedBioLabel.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
