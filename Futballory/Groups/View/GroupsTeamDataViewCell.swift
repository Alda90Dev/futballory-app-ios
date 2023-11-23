//
//  GroupsTeamDataViewCell.swift
//  Futballory
//
//  Created by Aldair Carrillo on 21/11/23.
//

import UIKit

class GroupsTeamDataViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: GroupsTeamDataViewCell.self)
    
    private lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private lazy var teamRowView: TeamRowView = {
        let view = TeamRowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var groupsDataView: GroupsDataView = {
        let view = GroupsDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackContainer.addArrangedSubview(teamRowView)
        stackContainer.addArrangedSubview(groupsDataView)
        
        contentView.addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func config(_ team: GroupTeam) {
        teamRowView.configure(flag: team.nationalTeamID.getFlagPathURL(), 
                              team: team.nationalTeamID.name)
        
        groupsDataView.configure(team)
    }
}
