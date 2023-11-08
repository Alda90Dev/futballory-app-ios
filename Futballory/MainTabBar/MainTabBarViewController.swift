//
//  MainTabBarViewController.swift
//  Futballory
//
//  Created by Aldair Carrillo on 03/11/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let controller1 = UIViewController()
        controller1.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = UIViewController()
        controller2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)
        
        let mainController = MainRouter.createMainModule()
        let navMain = UINavigationController(rootViewController: mainController)
        navMain.title = ""
        
        let controller4 = UIViewController()
        controller4.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
        let nav4 = UINavigationController(rootViewController: controller4)
        
        let controller5 = UIViewController()
        controller5.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 5)
        let nav5 = UINavigationController(rootViewController: controller5)
        
        viewControllers?.removeAll()
        viewControllers = [nav1, nav2, navMain, nav4, nav5]
        tabBar.backgroundColor = .white
        selectedIndex = 2
        
        setupMiddleButton()
    }
    
    private func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 72, height: 90))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 30
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.clear
        
        view.addSubview(menuButton)
        
        menuButton.setImage(ImageCatalog.iconWorldCup, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
}
