//
//  MainTabBarController.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 23.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let listVC = ListViewController()
        let usersVC = PeopleViewController()
        
        viewControllers = [
            generateNavController(rootVC: usersVC, title: "Users", image: UIImage(systemName: "person.2.fill")!),generateNavController(rootVC: listVC, title: "Chat", image: UIImage(systemName: "bubble.left.and.bubble.right")!), ]
    }
    private func generateNavController(rootVC:UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navVc = UINavigationController(rootViewController: rootVC)
        navVc.tabBarItem.title = title
        navVc.tabBarItem.image = image
        return navVc
        
    }
}
