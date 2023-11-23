//
//  GroupsDataView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 21/11/23.
//

import UIKit

class GroupsDataView: UIView {
    
    private lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()

    private lazy var lblGamesPlayed: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    private lazy var lblGamesStatus: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    private lazy var lblGoalsDifference: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    private lazy var lblPoints: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor = .darkGray
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackContainer.addArrangedSubview(lblGamesPlayed)
        stackContainer.addArrangedSubview(lblGamesStatus)
        stackContainer.addArrangedSubview(lblGoalsDifference)
        stackContainer.addArrangedSubview(lblPoints)
        
        addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: topAnchor),
            stackContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(_ team: GroupTeam?) {
        let matches = team?.matches ?? 0
        let wins = team?.wins ?? 0
        let draws = team?.draws ?? 0
        let loses = team?.loses ?? 0
        let goalsDifference = team?.goalsDifference ?? 0
        let points = team?.points ?? 0
        
        lblGamesPlayed.text = team == nil ? "GP" : "\(matches)"
        lblGamesStatus.text = team == nil ? "W-D-L" : "\(wins)-\(draws)-\(loses)"
        lblGoalsDifference.text = team == nil ? "GD" : "\(goalsDifference)"
        lblPoints.text = team == nil ? "P" : "\(points)"
    }
}
