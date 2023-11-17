//
//  GroupsPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 16/11/23.
//

import Foundation
import Combine

/*/ GroupsPresenter Protocol */

protocol GroupsPresenterProtocol: AnyObject {
    var view: GroupsViewProtocol? { get set }
    var interactor: GroupsInteractorInputProtocol? { get set }
    var router: GroupsRouterProtocol? { get set }
    
    func bind(input: GroupsPresenterInput) -> GroupsPresenterOutput
    func navigate()
}

/*/ GroupsPresenter */

class GroupsPresenter {
    weak var view: GroupsViewProtocol?
    var interactor: GroupsInteractorInputProtocol?
    var router: GroupsRouterProtocol?
    var output: GroupsPresenterOutput = GroupsPresenterOutput()
    
    private var subscriptions =  Set<AnyCancellable>()
}

extension GroupsPresenter: GroupsPresenterProtocol {
    func bind(input: GroupsPresenterInput) -> GroupsPresenterOutput {
        input.groups.sink { [weak self] in
            self?.interactor?.getGroups()
        }.store(in: &subscriptions)
        
        return output
    }
    
    func navigate() {
        router?.goTo(from: view)
    }
}

extension GroupsPresenter: GroupsInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: GroupsResponse?, error: Error?) {
        if let error = error {
            output.groupsDataErrorPublisher.send(.failure(error))
        } else if let response = receivedData,
                  response.success {
            output.groupsDataErrorPublisher.send(.success(response.grouped))
        }
    }
}
