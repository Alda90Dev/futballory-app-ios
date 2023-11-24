//
//  StadiumsInteractor.swift
//  Futballory
//
//  Created by Aldair Carrillo on 23/11/23.
//

import Foundation

/*/ StadiumsInteractor Protocols */

protocol StadiumsInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: StadiumsResponse?, error: Error?)
}

protocol StadiumsInteractorInputProtocol {
    var presenter: StadiumsInteractorOutputProtocol? { get set }
    func getStadiums()
}

/*/ StadiumsInteractor */

class StadiumsInteractor: StadiumsInteractorInputProtocol {
    weak var presenter: StadiumsInteractorOutputProtocol?
    
    func getStadiums() {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getStadiums.path) { [weak self] (result: NetworkResult<StadiumsResponse>) in
            switch result {
            case .success(data: let response):
                self?.presenter?.interactorGetDataPresenter(receivedData: response, error: nil)
            case .failure(error: let error):
                self?.presenter?.interactorGetDataPresenter(receivedData: nil, error: error)
            }
        }
    }
}
