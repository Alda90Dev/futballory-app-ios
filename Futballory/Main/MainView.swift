//
//  MainView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 03/11/23.
//

import UIKit

/////////////////////// MAIN VIEW  PROTOCOL

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// MAIN VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////
///

class MainView: UIViewController {
    var presenter: MainPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        table.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableHeaderView = imageTop
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        return table
    }()

    private lazy var imageTop: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = ImageCatalog.imgHome
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    var characters = ["Link1", "Zelda2", "Ganondorf3", "Midna4","Link5", "Zelda6", "Ganondorf7", "Midna8","Link9", "Zelda10", "Ganondorf11", "Midna12",
                      "Link13", "Zelda14", "Ganondorf15", "Midna16","Link17", "Zelda18", "Ganondorf19", "Midna","Link", "Zelda", "Ganondorf", "Midna",
                      "Link20", "Zelda21", "Ganondorf22", "Midna23","Link24", "Zelda25", "Ganondorf26", "Midna27","Link28", "Zelda29", "Ganondorf30", "Midna31",
                      "Link32", "Zelda33", "Ganondorf34", "Midna35","Link36", "Zelda37", "Ganondorf38", "Midna","Link", "Zelda", "Ganondorf", "Midna",
                      "Link39", "Zelda40", "Ganondorf41", "Midna42","Link43", "Zelda44", "Ganondorf45", "Midna46","Link47", "Zelda48", "Ganondorf49", "Midna50"
                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
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
        
        tableView.reloadData()
    }
}

extension MainView: MainViewProtocol { }

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row]
        cell.textLabel?.textColor = .gray
        return cell
    }
}
