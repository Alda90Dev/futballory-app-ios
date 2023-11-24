//
//  SatadiumsView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 23/11/23.
//

import UIKit
import Combine

/*/ StadiumsView Protocol */

protocol StadiumsViewProtocol: AnyObject {
    var presenter: StadiumsPresenterProtocol? { get set }
}

/*/ StadiumsView */

class StadiumsView: UIViewController {
    var presenter: StadiumsPresenterProtocol?
    
    private var subscriptions = Set<AnyCancellable>()
    private let presenterInput = StadiumsPresenterInput()
    private let appearance = UINavigationBarAppearance()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .init(x: 0, y: 0, width: 0, height: 0))
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.allowsSelection = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var stadiums: [Stadium] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Content.mainTabBarTitles.stadiums
        view.backgroundColor = .white
        setupTableView()
        bind()
        presenterInput.stadiums.send()
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
        
        output?.stadiumsDataErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .success(let data):
                    self?.stadiums = data
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

extension StadiumsView: StadiumsViewProtocol { }

extension StadiumsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stadiums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = stadiums[indexPath.row].name
        
        return cell
    }
}

extension StadiumsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
