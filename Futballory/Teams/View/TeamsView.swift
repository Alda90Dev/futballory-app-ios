//
//  TeamsView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 22/11/23.
//

import UIKit
import Combine

/*/ TeamsView Protocol */

protocol TeamsViewProtocol: AnyObject {
    var presenter: TeamsPresenterProtocol? { get set }
}

/*/ TeamsView */

class TeamsView: UIViewController {
    var presenter: TeamsPresenterProtocol?
    
    private var subscriptions = Set<AnyCancellable>()
    private let presenterInput = TeamsPresenterInput()
    private let appearance = UINavigationBarAppearance()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .init(x: 0, y: 0, width: 0, height: 0))
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.reuseIdentifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var teams: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Content.mainTabBarTitles.teams
        view.backgroundColor = .white
        setupTableView()
        bind()
        presenterInput.teams.send()
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
        
        output?.teamsDataErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .success(let data):
                    self?.teams = data
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

extension TeamsView: TeamsViewProtocol { }

extension TeamsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.reuseIdentifier, for: indexPath) as? TeamTableViewCell else {
            return UITableViewCell()
        }
        cell.config(teams[indexPath.row])
        return cell
    }
}

extension TeamsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenterInput.goToDetail.send(teams[indexPath.row])
    }
}
