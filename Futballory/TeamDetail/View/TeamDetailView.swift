//
//  TeamDetailView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import UIKit
import Combine
import SDWebImage

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
        table.tableHeaderView = viewTop
        table.allowsSelection = false
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var viewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageTeam: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private var imageURL: URL? {
        didSet {
            setupImage()
        }
    }
    
    private var teamPlayers: [TeamPlayers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        bind()
        presenterInput.teamData.send()
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
                    self?.teamPlayers = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.presentAlert(Content.errorMessage, message: error.localizedDescription)
                }
            }).store(in: &subscriptions)
        
        output?.teamDataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                self?.title = result.0
                self?.imageURL = result.1
            }).store(in: &subscriptions)
    }

    private func setupTableView() {
        viewTop.addSubview(imageTeam)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            viewTop.topAnchor.constraint(equalTo: tableView.topAnchor),
            viewTop.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            viewTop.heightAnchor.constraint(equalToConstant: 250),
            
            imageTeam.widthAnchor.constraint(equalToConstant: 200),
            imageTeam.heightAnchor.constraint(equalToConstant: 115),
            imageTeam.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor),
            imageTeam.centerXAnchor.constraint(equalTo: viewTop.centerXAnchor)
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
    
    private func setupImage() {
        if let url = imageURL {
            imageTeam.sd_setImage(with: url) { [weak self] image, error, _, _ in
                if let self = self,
                   let image = image {
                    self.imageTeam.image = image
                }
            }
        }
    }
}

extension TeamDetailView: TeamDetailViewProtocol { }

extension TeamDetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return teamPlayers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamPlayers[section].players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = teamPlayers[indexPath.section].players[indexPath.row].name
        return cell
    }
}

extension TeamDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.text = teamPlayers[section].playerType.rawValue
        view.addSubview(lbl)
        return view
    }
}
