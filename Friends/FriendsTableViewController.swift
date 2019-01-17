//
//  FriendsTableViewController.swift
//  Friends
//
//  Created by David Doswell on 1/17/19.
//  Copyright © 2019 David Doswell. All rights reserved.
//

import UIKit

struct Friend {
    var imageView: Data
    var name: String
    var bio: String
}

class FriendsTableViewController: UITableViewController, FriendProviding, UIViewControllerTransitioningDelegate {

    var image: UIImageView!
    var label: UILabel!
    var bio: UILabel!
    
    var friend: Friend?
    var friends: [Friend] = []

    let friendImage = UIImageView()
    
    let navigationControllerDelegate = NavigationControllerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Friends"
        
        friendImage.image = UIImage(named: "David")
        guard let imageData = friendImage.image?.pngData() else { return }
        let friend = Friend(imageView: imageData, name: "David", bio: "iOS Engineer")
        friends.append(friend)
        
        friendImage.contentMode = .scaleAspectFill
        
        navigationController?.delegate = navigationControllerDelegate
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let friend = friends[indexPath.row]
        cell.imageView?.image = UIImage(data: friend.imageView)
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.bio
        
        cell.selectionStyle = .none

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            segue.destination.transitioningDelegate = self
            let destination = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!
            let friends = self.friends[index.row]
            destination.friend = friends
            navigationControllerDelegate.sourceCell = tableView.cellForRow(at: index)
        }
    }

}
