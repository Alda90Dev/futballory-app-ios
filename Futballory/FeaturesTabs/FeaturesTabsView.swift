//
//  tabManView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit
import Tabman
import Pageboy
import Combine

protocol FeaturesTabsViewProtocol: AnyObject {
    var presenter: FeaturesTabsPresenterProtocol? { get set }
}

class FeaturesTabsView: TabmanViewController {
    var presenter: FeaturesTabsPresenterProtocol?
    
    private var subscriptions = Set<AnyCancellable>()
    private let presenterInput = FeaturesTabsPresenterInput()
    private var viewControllers: [UIViewController] = []
    private var lblTabs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        
        bind()
        presenterInput.dates.send()
    }
    
    private func bind() {
        let output = presenter?.bind(input: presenterInput)
        
        output?.featuresTabsDataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                self?.initTabBar(result)
            }).store(in: &subscriptions)
    }
    
    private func initTabBar(_ dataFeatures: [DataFeature]) {
        
        dataFeatures.forEach { data in
            viewControllers.append(FeaturesRouter.createFeaturesModule(featureDate: data.date))
            lblTabs.append(data.lblDate)
        }
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

extension FeaturesTabsView: FeaturesTabsViewProtocol { }

extension FeaturesTabsView: PageboyViewControllerDataSource {
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

extension FeaturesTabsView: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = " \(lblTabs[index])"
        return TMBarItem(title: title)
    }
}
