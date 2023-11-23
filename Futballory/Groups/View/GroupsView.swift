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
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .init(x: 0, y: 0, width: 0, height: 0))
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(GroupsTeamDataViewCell.self, forCellReuseIdentifier: GroupsTeamDataViewCell.reuseIdentifier)
        table.allowsSelection = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Content.mainTabBarTitles.groups
        view.backgroundColor = .white
        setupTableView()
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
                    self?.groups = data
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

extension GroupsView: GroupsViewProtocol {  }

extension GroupsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[section].teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTeamDataViewCell.reuseIdentifier, for: indexPath)  as? GroupsTeamDataViewCell else {
            return UITableViewCell()
        }
        
        cell.config(groups[indexPath.section].teams[indexPath.row])
        return cell
    }
}

extension GroupsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GroupsTitleDataView()
        view.configure(groups[section].group)
        return view
    }
}
