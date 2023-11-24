//
//  StadiumsRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 23/11/23.
//

import UIKit

/*/ StadiumsRouter Protocol */

protocol StadiumsRouterProtocol {
    static func createStadiumsModule() -> UIViewController
}

/*/ StadiumsRouter */

class StadiumsRouter: StadiumsRouterProtocol {
    static func createStadiumsModule() -> UIViewController {
        let view = StadiumsView()
        let interactor = StadiumsInteractor()
        let presenter: StadiumsPresenterProtocol & StadiumsInteractorOutputProtocol = StadiumsPresenter()
        let router = StadiumsRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
