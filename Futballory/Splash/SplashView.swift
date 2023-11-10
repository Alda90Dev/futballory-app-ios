//
//  SplashView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 08/11/23.
//

import UIKit
import ProgressHUD
import Combine

/*/ SplashView Protocol  */

protocol SplashViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }
}

/*/ SplashView  */

class SplashView: UIViewController {
    var presenter: SplashPresenterProtocol?
    
    private var subscriptions = Set<AnyCancellable>()
    private let presenterInput: SplashPresenterInput = SplashPresenterInput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ProgressHUD.animationType = .circleArcDotSpin
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.colorHUD = .white.withAlphaComponent(0)
        ProgressHUD.animate()
        
        bind()
        presenterInput.login.send()
    }
    
    private func bind() {
        let output = presenter?.bind(input: presenterInput)
        
        output?.splashDataErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                ProgressHUD.remove()
                self?.presentAlert(Content.errorMessage, message: error?.localizedDescription)
            }).store(in: &subscriptions)
    }
    
    private func presentAlert(_ title: String, message: String?) {
        self.openAlert(title: title,
                       message: message,
                       alertStyle: .alert,
                       actionTitles: [Content.alert.okMessage],
                       actionStyle: [.default],
                       actions: [nil])
    }
}

extension SplashView: SplashViewProtocol { }
