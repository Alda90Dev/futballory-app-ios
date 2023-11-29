//
//  TeamDetailRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import UIKit

/*/ TeamDetailRouter Protocol */

protocol TeamDetailRouterProtocol {
    static func createTeamDetailModule() -> UIViewController
}

/*/ TeamDetailRouter */

class TeamDetailRouter: TeamDetailRouterProtocol {
    static func createTeamDetailModule() -> UIViewController {
        let view = TeamDetailView()
        let interactor = TeamDetailInteractor()
        let presenter: TeamDetailPresenterProtocol & TeamDetailInteractorOutputProtocol = TeamDetailPresenter()
        let router = TeamDetailRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
