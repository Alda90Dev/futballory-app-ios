//
//  TeamsRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 22/11/23.
//

import UIKit

/*/ TeamsRouter Protocol */

protocol TeamsRouterProtocol {
    static func createTeamsModule() -> UIViewController
    func goTo(from view: TeamsViewProtocol?)
}

/*/ TeamsRouter */

class TeamsRouter: TeamsRouterProtocol {
    static func createTeamsModule() -> UIViewController {
        let view = TeamsView()
        let interactor = TeamsInteractor()
        let presenter: TeamsPresenterProtocol & TeamsInteractorOutputProtocol = TeamsPresenter()
        let router = TeamsRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func goTo(from view: TeamsViewProtocol?) {
    }
}
