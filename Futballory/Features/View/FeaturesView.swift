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
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .init(x: 0, y: 0, width: 0, height: 0))
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FeatureViewCell.self, forCellReuseIdentifier: FeatureViewCell.resuseIdentifier)
        table.allowsSelection = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var matches: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
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
                    self?.matches = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.presentAlert(Content.errorMessage, message: error.localizedDescription)
                }
            }).store(in: &subscriptions)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
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

extension FeaturesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeatureViewCell.resuseIdentifier, for: indexPath) as? FeatureViewCell else {
            return UITableViewCell()
        }
        
        cell.config(matches[indexPath.row])
        return cell
    }
}

extension FeaturesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
