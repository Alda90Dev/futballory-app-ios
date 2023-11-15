//
//  SpashInteractor.swift
//  Futballory
//
//  Created by Aldair Carrillo on 08/11/23.
//

import Foundation

/*/ SplashInteractor Protocols */

protocol SplashInteractorOutputProtocol: AnyObject {
    func interactorGetDatesPresenter(receivedData: DateResponse?, error: Error?)
}

protocol SplashInteractorInputProtocol {
    var presenter: SplashInteractorOutputProtocol? { get set }
    func loginApp()
    func getDates()
}

/*/ SplashInteractor  */

class SplashInteractor: SplashInteractorInputProtocol {
    weak var presenter: SplashInteractorOutputProtocol?
    
    func loginApp() {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getToken.path) { [weak self] (result: NetworkResult<TokenResponse>) in
            switch result {
            case .success(data: let response):
                NetworkManager.token = response.token
                self?.getDates()
            case .failure(error: let error):
                self?.presenter?.interactorGetDatesPresenter(receivedData: nil, error: error)
            }
        }
    }
    
    func getDates() {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getDates.path) { [weak self] (result: NetworkResult<DateResponse>) in
            switch result {
            case .success(data: let response):
                self?.presenter?.interactorGetDatesPresenter(receivedData: response, error: nil)
            case .failure(error: let error):
                self?.presenter?.interactorGetDatesPresenter(receivedData: nil, error: error)
            }
        }
    }

}
