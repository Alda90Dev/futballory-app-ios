//
//  TeamsInteractor.swift
//  Futballory
//
//  Created by Aldair Carrillo on 22/11/23.
//

import Foundation

/*/ TeamsInteractor Protocol */

protocol TeamsInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: TeamsResponse?, error: Error?)
}

protocol TeamsInteractorInputProtocol {
    var presenter: TeamsInteractorOutputProtocol? { get set }
    func getTeams()
}

/*/ TeamsInteractor */

class TeamsInteractor: TeamsInteractorInputProtocol {
    weak var presenter: TeamsInteractorOutputProtocol?
    
    func getTeams() {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getTeams.path) { [weak self] (result: NetworkResult<TeamsResponse>) in
            switch result {
            case .success(data: let response):
                self?.presenter?.interactorGetDataPresenter(receivedData: response, error: nil)
            case .failure(error: let error):
                self?.presenter?.interactorGetDataPresenter(receivedData: nil, error: error)
            }
        }
    }
}
