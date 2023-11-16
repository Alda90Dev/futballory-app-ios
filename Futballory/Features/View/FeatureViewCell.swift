//
//  FeatureViewCell.swift
//  Futballory
//
//  Created by Aldair Carrillo on 15/11/23.
//

import UIKit

class FeatureViewCell: UITableViewCell {
    
    static let resuseIdentifier = String(describing: FeatureViewCell.self)
    
    private lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private lazy var lblStatus: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var viewLocal: FeatureTeamView = {
        let view = FeatureTeamView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewGuest: FeatureTeamView = {
        let view = FeatureTeamView()
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

    private func setupUI(){
        stackContainer.addArrangedSubview(lblStatus)
        stackContainer.addArrangedSubview(viewLocal)
        stackContainer.addArrangedSubview(viewGuest)
        
        contentView.addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackContainer.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    func config(_ match: Match) {
        lblStatus.text = match.status.rawValue
        viewLocal.configure(flag: match.localTeam.getFlagPathURL(),
                            team: match.localTeam.name,
                            score: match.finalLocalScore())
       
        viewGuest.configure(flag: match.guestTeam.getFlagPathURL(),
                            team: match.guestTeam.name,
                            score: match.finalGuestScore())
    }
}
