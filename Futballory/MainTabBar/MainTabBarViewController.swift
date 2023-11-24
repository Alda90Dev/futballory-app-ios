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
        
        let featuresController = FeaturesTabsRouter.createFeaturesTabModule()
        let featuresOption = UITabBarItem()
        featuresOption.title = Content.mainTabBarTitles.features
        featuresOption.image = ImageCatalog.iconFeatures
        featuresOption.selectedImage = ImageCatalog.iconFeaturesSelected
        featuresController.tabBarItem = featuresOption
        let navFeatures = UINavigationController(rootViewController: featuresController)
        
        
        let groupsController = GroupsRouter.createGroupsModule()
        let groupsOption = UITabBarItem()
        groupsOption.title = Content.mainTabBarTitles.groups
        groupsOption.image = ImageCatalog.iconGroups
        groupsOption.selectedImage = ImageCatalog.iconGroupsSelected
        groupsController.tabBarItem = groupsOption
        let navGroups = UINavigationController(rootViewController: groupsController)
        
        let mainController = MainRouter.createMainModule()
        let navMain = UINavigationController(rootViewController: mainController)
        navMain.title = ""
        
        let teamsController = TeamsRouter.createTeamsModule()
        let teamsOption = UITabBarItem()
        teamsOption.title = Content.mainTabBarTitles.teams
        teamsOption.image = ImageCatalog.iconTeams
        teamsOption.selectedImage = ImageCatalog.iconTeamsSelected
        teamsController.tabBarItem = teamsOption
        let navTeams = UINavigationController(rootViewController: teamsController)
        
        let stadiumsController = StadiumsRouter.createStadiumsModule()
        let stadiumsOption = UITabBarItem()
        stadiumsOption.title = Content.mainTabBarTitles.stadiums
        stadiumsOption.image = ImageCatalog.iconStadiums
        stadiumsOption.selectedImage = ImageCatalog.iconStadiumsSelected
        stadiumsController.tabBarItem = stadiumsOption
        let navStadiums = UINavigationController(rootViewController: stadiumsController)
        
        viewControllers?.removeAll()
        viewControllers = [navFeatures, navGroups, navMain, navTeams, navStadiums]
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
