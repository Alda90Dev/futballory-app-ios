//
//  TeamDetailPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import Foundation
import Combine

/*/ TeamDetailPresenter Protocol */

protocol TeamDetailPresenterProtocol: AnyObject {
    var view: TeamDetailViewProtocol? { get set }
    var interactor: TeamDetailInteractorInputProtocol? { get set }
    var router: TeamDetailRouterProtocol? { get set }
    
    func bind(input: TeamDetailPresenterInput) -> TeamDetailPresenterOutput
}

/*/ TeamDetailPresenter */

class TeamDetailPresenter {
    weak var view: TeamDetailViewProtocol?
    var interactor: TeamDetailInteractorInputProtocol?
    var router: TeamDetailRouterProtocol?
    var output: TeamDetailPresenterOutput = TeamDetailPresenterOutput()
    
    private var subscriptions = Set<AnyCancellable>()
}

extension TeamDetailPresenter: TeamDetailPresenterProtocol {
    func bind(input: TeamDetailPresenterInput) -> TeamDetailPresenterOutput {
        input.players.sink { [weak self] in
            self?.interactor?.getPlayers(team: "65032ad8a69f72086f206296")
        }.store(in: &subscriptions)
        
        return output
    }
}

extension TeamDetailPresenter: TeamDetailInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: PlayersResponse?, error: Error?) {
        if let error = error {
            output.playersDataErrorPublisher.send(.failure(error))
        } else if let response = receivedData,
                  response.success {
            output.playersDataErrorPublisher.send(.success(response.players))
        }
    }
}
