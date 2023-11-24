//
//  TeamsPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 22/11/23.
//

import Foundation
import Combine

/*/ TeamsPresenter Protocol */

protocol TeamsPresenterProtocol: AnyObject {
    var view: TeamsViewProtocol? { get set }
    var interactor: TeamsInteractorInputProtocol? { get set }
    var router: TeamsRouterProtocol? { get set }
    
    func bind(input: TeamsPresenterInput) -> TeamsPresenterOutput
    func navigate()
}

/*/ TeamsPresenter */

class TeamsPresenter {
    weak var view: TeamsViewProtocol?
    var interactor: TeamsInteractorInputProtocol?
    var router: TeamsRouterProtocol?
    var output: TeamsPresenterOutput = TeamsPresenterOutput()
    
    private var subscriptions = Set<AnyCancellable>()
}

extension TeamsPresenter: TeamsPresenterProtocol {
    func bind(input: TeamsPresenterInput) -> TeamsPresenterOutput {
        input.teams.sink { [weak self] in
            self?.interactor?.getTeams()
        }.store(in: &subscriptions)
        
        return output
    }
    
    func navigate() {
        router?.goTo(from: view)
    }
}

extension TeamsPresenter: TeamsInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: TeamsResponse?, error: Error?) {
        if let error = error {
            output.teamsDataErrorPublisher.send(.failure(error))
        } else if let response = receivedData,
                  response.success {
            output.teamsDataErrorPublisher.send(.success(response.nationalTeams))
        }
    }
}
