//
//  MainTabBarController.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 23.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listVC = ListViewController(currentUser: currentUser)
        let usersVC = PeopleViewController(currentUser: currentUser)
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
