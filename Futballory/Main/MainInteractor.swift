//
//  MainInteractor.swift
//  Futballory
//
//  Created by Aldair Carrillo on 09/11/23.
//

import Foundation

/*/ MainInteractor Protocols */

protocol  MainInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: MatchResponse?, error: Error?)
}

protocol MainInteractorInputProtocol {
    var presenter: MainInteractorOutputProtocol? { get set }
    func getMatches(date: String)
}

/*/ MainInteractor */

class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    
    func getMatches(date: String) {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getMatches(date: date).path) { [weak self] (result: NetworkResult<MatchResponse>) in
            switch result {
            case .success(data: let response):
                self?.presenter?.interactorGetDataPresenter(receivedData: response, error: nil)
            case .failure(error: let error):
                self?.presenter?.interactorGetDataPresenter(receivedData: nil, error: error)
            }
        }
    }
}
