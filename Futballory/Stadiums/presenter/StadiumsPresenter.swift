//
//  StadiumsPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 23/11/23.
//

import Foundation
import Combine

/*/ StadiumsPresenter Procotol */

protocol StadiumsPresenterProtocol: AnyObject {
    var view: StadiumsViewProtocol? { get set }
    var interactor: StadiumsInteractorInputProtocol? { get set }
    var router: StadiumsRouterProtocol? { get set }
    
    func bind(input: StadiumsPresenterInput) -> StadiumsPresenterOutput
}

/*/ StadiumsPresenter */

class StadiumsPresenter {
    weak var view: StadiumsViewProtocol?
    var interactor: StadiumsInteractorInputProtocol?
    var router: StadiumsRouterProtocol?
    var output: StadiumsPresenterOutput = StadiumsPresenterOutput()
    
    private var subscriptions = Set<AnyCancellable>()
}

extension StadiumsPresenter: StadiumsPresenterProtocol {
    func bind(input: StadiumsPresenterInput) -> StadiumsPresenterOutput {
        input.stadiums.sink { [weak self] in
            self?.interactor?.getStadiums()
        }.store(in: &subscriptions)
        
        return output
    }
}

extension StadiumsPresenter: StadiumsInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: StadiumsResponse?, error: Error?) {
        if let error = error {
            output.stadiumsDataErrorPublisher.send(.failure(error))
        } else if let response = receivedData,
                  response.success {
            output.stadiumsDataErrorPublisher.send(.success(response.stadiums))
        }
    }
}
