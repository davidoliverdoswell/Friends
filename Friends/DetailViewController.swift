//
//  DetailViewController.swift
//  Friends
//
//  Created by David Doswell on 1/17/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, FriendProviding, UIViewControllerTransitioningDelegate {
    
    var friend: Friend!
    
    var image: UIImageView!
    var label: UILabel!
    var bio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        view.backgroundColor = .orange
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
}
