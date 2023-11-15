//
//  FeaturesPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 14/11/23.
//

import Combine
import Foundation

/*/ FeaturesPresenter Protocol */

protocol FeaturesPresenterProtocol: AnyObject {
    var view: FeaturesViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var router: FeaturesRouterProtocol? { get set }
    var featureDate: String? { get set }
    
    func bind(input: MainPresenterInput) -> MainPresenterOutput
    func navigate()
}

/*/ FeaturesPresenter */

class FeaturesPresenter {
    weak var view: FeaturesViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: FeaturesRouterProtocol?
    var output: MainPresenterOutput = MainPresenterOutput()
    var featureDate: String?
    
    private var subscriptions = Set<AnyCancellable>()
}

extension FeaturesPresenter: FeaturesPresenterProtocol {
    func bind(input: MainPresenterInput) -> MainPresenterOutput {
        input.matches.sink { [weak self] in
            let date = self?.featureDate ?? ""
            self?.interactor?.getMatches(date: date)
        }.store(in: &self.subscriptions)
        
        return output
    }
    
    func navigate() {
        router?.goTo(from: view)
    }
}

extension FeaturesPresenter: MainInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: MatchResponse?, error: Error?) {
        if let error = error {
            output.mainDataErrorPublisher.send(.failure(error))
        } else if let response = receivedData,
                  response.success {
            output.mainDataErrorPublisher.send(.success(response.matches))
        }
    }
}
