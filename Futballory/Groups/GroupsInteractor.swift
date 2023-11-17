//
//  GroupsInteractor.swift
//  Futballory
//
//  Created by Aldair Carrillo on 16/11/23.
//

import Foundation

/*/ GroupsInteractor Protocol */

protocol GroupsInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: GroupsResponse?, error: Error?)
}

protocol GroupsInteractorInputProtocol {
    var presenter: GroupsInteractorOutputProtocol? { get set }
    func getGroups()
}

/*/ GroupsInteractor  */

class GroupsInteractor: GroupsInteractorInputProtocol {
    weak var presenter: GroupsInteractorOutputProtocol?
    
    func getGroups() {
        NetworkManager.shared.request(networkRouter: NetworkEndpoints.getGroups.path) { [weak self] (result: NetworkResult<GroupsResponse>) in
            switch result {
            case.success(data: let response):
                self?.presenter?.interactorGetDataPresenter(receivedData: response, error: nil)
            case .failure(error: let error):
                self?.presenter?.interactorGetDataPresenter(receivedData: nil, error: error)
            }
        }
    }
}
