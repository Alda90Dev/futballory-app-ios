//
//  SpashInteractor.swift
//  Futballory
//
//  Created by Aldair Carrillo on 08/11/23.
//

import Foundation

/*/ SplashInteractor Protocols */

protocol SplashInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: TokenResponse?, error: Error?)
}

protocol SplashInteractorInputProtocol {
    var presenter: SplashInteractorOutputProtocol? { get set }
    func loginApp()
}

/*/ SplashInteractor  */

class SplashInteractor: SplashInteractorInputProtocol {
    weak var presenter: SplashInteractorOutputProtocol?
    
    func loginApp() {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getToken.path) { [weak self] (result: NetworkResult<TokenResponse>) in
            guard let self = self else { return }
            switch result {
            case .success(data: let response):
                self.presenter?.interactorGetDataPresenter(receivedData: response, error: nil)
            case .failure(error: let error):
                self.presenter?.interactorGetDataPresenter(receivedData: nil, error: error)
            }
        }
    }
}
