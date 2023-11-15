//
//  FeaturesRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit

/*/ FeaturesTabsRouter Protocol */

protocol FeaturesTabsRouterProtocol {
    static func createFeaturesTabModule() -> UIViewController
}

/*/ FeaturesTabsRouter */

class FeaturesTabsRouter: FeaturesTabsRouterProtocol {
    static func createFeaturesTabModule() -> UIViewController {
        let view = FeaturesTabsView()
        let presenter: FeaturesTabsPresenterProtocol = FeaturesTabsPresenter()
        let router = FeaturesTabsRouter()
        
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
