//
//  tabManView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit
import Tabman
import Pageboy

class TabManView: TabmanViewController {
    private var viewControllers = [FeaturesRouter.createFeaturesModule(), FeaturesRouter.createFeaturesModule()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension TabManView: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}

extension TabManView: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = " Page \(index)"
        return TMBarItem(title: title)
    }
}
