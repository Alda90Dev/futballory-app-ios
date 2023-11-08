//
//  MainRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 03/11/23.
//

import UIKit

/////////////////////// MAIN ROUTER  PROTOCOL

protocol MainRouterProtocol {
    static func createMainModule() -> UIViewController
    func goTo(from view: MainViewProtocol)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// MAIN ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
///

class MainRouter: MainRouterProtocol {
    static func createMainModule() -> UIViewController {
        let view = MainView()
        let presenter: MainPresenterProtocol = MainPresenter()
        let router = MainRouter()
        
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func goTo(from view: MainViewProtocol) {
        
    }
}


