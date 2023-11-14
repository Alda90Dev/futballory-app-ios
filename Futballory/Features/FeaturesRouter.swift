//
//  FeaturesRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit

/*/ FeaturesRouter Protocol */

protocol FeaturesRouterProtocol {
    static func createFeaturesModule() -> UIViewController
    func goTo(from view: FeaturesViewProtocol?)
}

/*/ FeaturesRouter */

class FeaturesRouter: FeaturesRouterProtocol {
    static func createFeaturesModule() -> UIViewController {
        let view = FeaturesView()
        let interactor = MainInteractor()
        let presenter: FeaturesPresenterProtocol & MainInteractorOutputProtocol = FeaturesPresenter()
        let router = FeaturesRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func goTo(from view: FeaturesViewProtocol?) {
        
    }
}
