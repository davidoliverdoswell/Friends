//
//  DetailViewController.swift
//  Friends
//
//  Created by David Doswell on 1/17/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, LabelProviding {
    
    var friend: Friend?
    var label: UILabel!
    var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
}
