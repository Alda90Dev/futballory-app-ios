//
//  MainPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 03/11/23.
//

import Combine
import Foundation

/*/ MainPresenter Protocol */

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    
    func bind(input: MainPresenterInput) -> MainPresenterOutput
    func navigate()
}

/*/ MainPresenter */

class MainPresenter {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    var output: MainPresenterOutput = MainPresenterOutput()
    
    private var subscriptions = Set<AnyCancellable>()
}

extension MainPresenter: MainPresenterProtocol {
    
    func bind(input: MainPresenterInput) -> MainPresenterOutput {
        input.matches.sink { [weak self] in
            let today = Date.now
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.string(from: today)
            self?.interactor?.getMatches(date: date)
        }.store(in: &self.subscriptions)
        
        return output
    }
    
    func navigate() {
        router?.goTo(from: view)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: MatchResponse?, error: Error?) {
        
        if let error = error {
            output.mainDataErrorPublisher.send(.failure(error))
        } else if let response = receivedData,
           response.success {
            output.mainDataErrorPublisher.send(.success(response.matches))
        }
    }
}

