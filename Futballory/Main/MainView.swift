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
    
    var characters = ["Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna",
                      "Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna",
                      "Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna",
                      "Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna",
                      "Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna","Link", "Zelda", "Ganondorf", "Midna"
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
