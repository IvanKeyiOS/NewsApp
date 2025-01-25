//
//  TabBarController.swift
//  NewsApp
//
//  Created by Иван Курганский on 19/01/2025.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = .black
        setupViewController()
    }
    
    private func setupViewController() {
        
                         
      
        viewControllers = [setupNavigationController(rootViewController: GeneralViewController(),
                                                     title: "General",
                                                     image: UIImage(systemName: "newspaper") ?? UIImage.add) ,
                           setupNavigationController(rootViewController: BusinessViewController(),
                                                                        title: "Business",
                                                                        image: UIImage(systemName: "briefcase") ?? UIImage.add),
                           setupNavigationController(rootViewController: TechnologyViewController(),
                                                                        title: "Technology",
                                                                        image: UIImage(systemName: "gyroscope") ?? UIImage.add)]
    }
    
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
