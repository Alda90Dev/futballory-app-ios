//
//  MainView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 03/11/23.
//

import UIKit
import Combine

/*/ MainView Protocol */

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
}

/*/ MainView */

class MainView: UIViewController {
    var presenter: MainPresenterProtocol?
    
    private var subscriptions = Set<AnyCancellable>()
    private let presenterInput = MainPresenterInput()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        table.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableHeaderView = imageTop
        table.register(MainMatchViewCell.self, forCellReuseIdentifier: MainMatchViewCell.reuseIdentifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private lazy var imageTop: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = ImageCatalog.imgHome
        img.contentMode = .scaleAspectFill
        return img
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            imageTop.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            imageTop.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            imageTop.topAnchor.constraint(equalTo: tableView.topAnchor),
            imageTop.heightAnchor.constraint(equalToConstant: 350)
        ])
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

extension MainView: MainViewProtocol { }

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMatchViewCell.reuseIdentifier, for: indexPath) as? MainMatchViewCell else {
            return UITableViewCell()
        }
        
        cell.config(matches[indexPath.row])
        return cell
    }
}

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
