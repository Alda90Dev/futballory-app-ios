//
//  FeaturesView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit
import Combine

/*/ FeaturesView Protocol */

protocol FeaturesViewProtocol: AnyObject {
    var presenter: FeaturesPresenterProtocol? { get set }
}

/*/ FeaturesView */

class FeaturesView: UIViewController {
    var presenter: FeaturesPresenterProtocol?
    
    private var subscriptions =  Set<AnyCancellable>()
    private let presenterInput = MainPresenterInput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        presenterInput.matches.send()
    }
    
    private func bind() {
        let output = presenter?.bind(input: presenterInput)
        
        output?.mainDataErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .success(let data):
                    debugPrint("MATCHES", data)
                case .failure(let error):
                    self?.presentAlert(Content.errorMessage, message: error.localizedDescription)
                }
            }).store(in: &subscriptions)
    }
    
    private func presentAlert(_ title: String, message: String?) {
        self.openAlert(title: title,
                       message: message,
                       alertStyle: .alert, actionTitles: [Content.alert.okMessage],
                       actionStyle: [.default],
                       actions: [nil])
    }
}

extension FeaturesView: FeaturesViewProtocol { }
