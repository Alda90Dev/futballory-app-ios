//
//  TeamDetailRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import UIKit

/*/ TeamDetailRouter Protocol */

protocol TeamDetailRouterProtocol {
    static func createTeamDetailModule(team: Team) -> UIViewController
}

/*/ TeamDetailRouter */

class TeamDetailRouter: TeamDetailRouterProtocol {
    static func createTeamDetailModule(team: Team) -> UIViewController {
        let view = TeamDetailView()
        let interactor = TeamDetailInteractor()
        let presenter: TeamDetailPresenterProtocol & TeamDetailInteractorOutputProtocol = TeamDetailPresenter(team: team)
        let router = TeamDetailRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
