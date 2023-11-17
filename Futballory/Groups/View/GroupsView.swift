//
//  GroupsView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 16/11/23.
//

import UIKit
import Combine

/*/ GroupsView Protocol */

protocol GroupsViewProtocol: AnyObject {
    var presenter: GroupsPresenterProtocol? { get set }
}

/*/ GroupsView */

class GroupsView: UIViewController {
    var presenter: GroupsPresenterProtocol?
    
    private var subscriptions = Set<AnyCancellable>()
    private let presenterInput = GroupsPresenterInput()
    private let appearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Content.mainTabBarTitles.groups
        view.backgroundColor = .white
        bind()
        presenterInput.groups.send()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appearance.backgroundColor = .blue
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func bind() {
        let output = presenter?.bind(input: presenterInput)
        
        output?.groupsDataErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .success(let data):
                    debugPrint("Grupos", data)
                case .failure(let error):
                    self?.presentAlert(Content.errorMessage, message: error.localizedDescription)
                }
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

extension GroupsView: GroupsViewProtocol {  }
