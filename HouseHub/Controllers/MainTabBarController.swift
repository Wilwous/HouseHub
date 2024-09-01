//
//  MainTabBarController.swift
//  HouseHub
//
//  Created by Антон Павлов on 30.08.2024.
//


import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    // MARK: - Private Methods
    
    private func setupTabBarAppearance() {
        view.backgroundColor = .white
        
        tabBar.tintColor = .wDeepNavyBlue
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
    
    private func setupViewControllers() {
        let dashboardVC = DashboardViewController()
        let dashboardNav = UINavigationController(rootViewController: dashboardVC)
        dashboardNav.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "key.fill"),
            selectedImage: UIImage(systemName: "key.fill")
        )
        
        let emptyVC1 = UIViewController()
        emptyVC1.view.backgroundColor = .white
        emptyVC1.tabBarItem = UITabBarItem(
            title: "Заявки",
            image: UIImage(systemName: "checklist"),
            selectedImage: UIImage(systemName: "checklist")
        )
        
        let emptyVC2 = UIViewController()
        emptyVC2.view.backgroundColor = .white
        emptyVC2.tabBarItem = UITabBarItem(
            title: "Услуги",
            image: UIImage(systemName: "star.fill"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        let emptyVC3 = UIViewController()
        emptyVC3.view.backgroundColor = .white
        emptyVC3.tabBarItem = UITabBarItem(
            title: "Чат",
            image: UIImage(systemName: "message.fill"),
            selectedImage: UIImage(systemName: "message.fill")
        )
        
        let emptyVC4 = UIViewController()
        emptyVC4.view.backgroundColor = .white
        emptyVC4.tabBarItem = UITabBarItem(
            title: "Контакты",
            image: UIImage(systemName: "person.crop.rectangle.fill"),
            selectedImage: UIImage(systemName: "person.crop.rectangle.fill")
        )
        
        viewControllers = [dashboardNav, emptyVC1, emptyVC2, emptyVC3, emptyVC4]
    }
}
