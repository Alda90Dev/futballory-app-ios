//
//  MainRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 03/11/23.
//

import UIKit

/*/ MainRouter Protocol */

protocol MainRouterProtocol {
    static func createMainModule() -> UIViewController
    func goTo(from view: MainViewProtocol?)
}

/*/ MainRouter */

class MainRouter: MainRouterProtocol {
    static func createMainModule() -> UIViewController {
        let view = MainView()
        let interactor = MainInteractor()
        let presenter: MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
        let router = MainRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func goTo(from view: MainViewProtocol?) {
        
    }
}


