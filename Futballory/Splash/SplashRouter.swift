//
//  SplashRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 08/11/23.
//

import UIKit

/*/ SplashRouter Protocol  */

protocol SplashRouterProtocol {
    static func createSplashModule() -> UIViewController
    func goTo(from view: SplashViewProtocol?)
}

/*/ SplashRouter */

class SplashRouter: SplashRouterProtocol {
    static func createSplashModule() -> UIViewController {
        let view = SplashView()
        let interactor = SplashInteractor()
        let presenter: SplashPresenterProtocol & SplashInteractorOutputProtocol = SplashPresenter()
        let router = SplashRouter()
        
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func goTo(from view: SplashViewProtocol?) {
        if let vc = view as? UIViewController {
            let mainTabBar = MainTabBarViewController()
            mainTabBar.modalTransitionStyle = .crossDissolve
            mainTabBar.modalPresentationStyle = .fullScreen
            vc.present(mainTabBar, animated: true)
        }
    }
}
