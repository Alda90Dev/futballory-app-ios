//
//  GroupsTitleDataView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 21/11/23.
//

import UIKit

class GroupsTitleDataView: UIView {

    private lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()

    private lazy var lblGroupTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .darkText
        return lbl
    }()
    
    private lazy var groupsDataView: GroupsDataView = {
        let view = GroupsDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackContainer.addArrangedSubview(lblGroupTitle)
        stackContainer.addArrangedSubview(groupsDataView)
        
        addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: topAnchor),
            stackContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(_ title: String) {
        lblGroupTitle.text = title
        groupsDataView.configure(nil)
    }
}
