//
//  TeamDetailInteractor.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import Foundation

/*/ TeamDetailInteractor Protocols */

protocol TeamDetailInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: PlayersResponse?, error: Error?)
}

protocol TeamDetailInteractorInputProtocol {
    var presenter: TeamDetailInteractorOutputProtocol? { get set }
    func getPlayers(team: String)
}

/*/ TeamDetailInteractor */

class TeamDetailInteractor: TeamDetailInteractorInputProtocol {
    weak var presenter: TeamDetailInteractorOutputProtocol?
    
    func getPlayers(team: String) {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getPlayers(team: team).path) { [weak self] (result: NetworkResult<PlayersResponse>) in
            switch result {
            case .success(data: let response):
                self?.presenter?.interactorGetDataPresenter(receivedData: response, error: nil)
            case .failure(error: let error):
                self?.presenter?.interactorGetDataPresenter(receivedData: nil, error: error)
            }
        }
    }
}
