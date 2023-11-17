//
//  GroupsRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 16/11/23.
//

import UIKit

/*/ GroupsRouter Protocol */

protocol GroupsRouterProtocol {
    static func createGroupsModule() -> UIViewController
    func goTo(from view: GroupsViewProtocol?)
}

/*/ GroupsRouter */

class GroupsRouter: GroupsRouterProtocol {
    static func createGroupsModule() -> UIViewController {
        let view = GroupsView()
        let interactor = GroupsInteractor()
        let presenter: GroupsPresenterProtocol & GroupsInteractorOutputProtocol = GroupsPresenter()
        let router = GroupsRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func goTo(from view: GroupsViewProtocol?) {
    }
}
