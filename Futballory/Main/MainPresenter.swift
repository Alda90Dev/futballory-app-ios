//
//  MainPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 03/11/23.
//

import Foundation

/////////////////////// MAIN PRESENTER  PROTOCOL

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    
    func navigate()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// MAIN PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////
///

class MainPresenter {
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
}

extension MainPresenter: MainPresenterProtocol {
    func navigate() {
        router?.goTo(from: view!)
    }
}
