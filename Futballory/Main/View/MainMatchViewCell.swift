//
//  MainMatchViewCell.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit

class MainMatchViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MainMatchViewCell.self)
    
    private lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 3
        return stack
    }()
    
    private lazy var lblStatus: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var viewScore: MainMatchScoreView = {
        let view = MainMatchScoreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackTeams: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var lblLocal: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblGuest: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackContainer.addArrangedSubview(lblStatus)
        stackContainer.addArrangedSubview(viewScore)
        stackContainer.addArrangedSubview(stackTeams)
        
        stackTeams.addArrangedSubview(lblLocal)
        stackTeams.addArrangedSubview(lblGuest)
        
        contentView.addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackContainer.heightAnchor.constraint(equalToConstant: 115),
            
            viewScore.heightAnchor.constraint(equalToConstant: 60),
            stackTeams.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func config(_ match: Match) {
        lblStatus.text = match.status.rawValue
        lblLocal.text = match.localTeam.name
        lblGuest.text = match.guestTeam.name
        
        viewScore.configure(match)
    }
}
