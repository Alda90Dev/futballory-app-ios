//
//  TeamDetailView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import UIKit
import Combine

/*/ TeamDetailView Protocol */

protocol TeamDetailViewProtocol: AnyObject {
    var presenter: TeamDetailPresenterProtocol? { get set }
}

/*/ TeamDetailView */

class TeamDetailView: UIViewController {
    var presenter: TeamDetailPresenterProtocol?
    
    private var subscriptions =  Set<AnyCancellable>()
    private let presenterInput = TeamDetailPresenterInput()
    private let appearance = UINavigationBarAppearance()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .init(x: 0, y: 0, width: 0, height: 0))
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.allowsSelection = false
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Team Detail"
        view.backgroundColor = .white
        setupTableView()
        bind()
        presenterInput.players.send()
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
        
        output?.playersDataErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .success(let data):
                    self?.players = data
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
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
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

extension TeamDetailView: TeamDetailViewProtocol { }

extension TeamDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = players[indexPath.row].name
        return cell
    }
}

extension TeamDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
