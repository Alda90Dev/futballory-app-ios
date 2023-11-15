//
//  SplashPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 08/11/23.
//

import Combine

/*/ SplashPresenter Protocol */

protocol SplashPresenterProtocol: AnyObject {
    var view: SplashViewProtocol? { get set }
    var interactor: SplashInteractorInputProtocol? { get set }
    var router: SplashRouterProtocol? { get set }
    
    func bind(input: SplashPresenterInput) -> SplashPresenterOutput
}

/*/ SplashPresenter  */

class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashViewProtocol?
    var interactor: SplashInteractorInputProtocol?
    var router: SplashRouterProtocol?
    var output: SplashPresenterOutput = SplashPresenterOutput()
    
    private var subscriptions = Set<AnyCancellable>()
    
    func bind(input: SplashPresenterInput) -> SplashPresenterOutput {
        input.login.sink { [weak self] in
            self?.interactor?.loginApp()
        }.store(in: &self.subscriptions)
        
        return output
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func interactorGetDatesPresenter(receivedData: DateResponse?, error: Error?) {
        output.splashDataErrorPublisher.send(error)
        
        if let response = receivedData,
           response.success {
            Defaults.shared.dates = response.dates
            router?.goTo(from: view)
        }
    }
}
