//
//  MainMatchScoreView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit
import SDWebImage

class MainMatchScoreView: UIView {
    
    private lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var stackLocalTeam: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private lazy var lblVersus: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "-"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var stackGuestTeam: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private lazy var imageLocal: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var lblLocalScore: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 22)
        return lbl
    }()
    
    private lazy var imageGuest: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var lblGuestScore: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 22)
        return lbl
    }()
    
    private var localImageURL: URL? {
        didSet {
            setupLocalImage()
        }
    }
    
    private var guestImageURL: URL? {
        didSet {
            setupGuestImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackContainer.addArrangedSubview(stackLocalTeam)
        stackContainer.addArrangedSubview(stackGuestTeam)
        stackContainer.addSubview(lblVersus)
        
        stackLocalTeam.addArrangedSubview(imageLocal)
        stackLocalTeam.addArrangedSubview(lblLocalScore)
        
        stackGuestTeam.addArrangedSubview(lblGuestScore)
        stackGuestTeam.addArrangedSubview(imageGuest)
        
        addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: topAnchor),
            stackContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lblVersus.widthAnchor.constraint(equalToConstant: 15),
            lblVersus.centerYAnchor.constraint(equalTo: stackContainer.centerYAnchor),
            lblVersus.centerXAnchor.constraint(equalTo: stackContainer.centerXAnchor)
        ])
    }
    
    func configure(_ match: Match) {
        lblLocalScore.text = match.finalLocalScore()
        lblGuestScore.text = match.finalGuestScore()
        localImageURL = match.localTeam.getFlagPathURL()
        guestImageURL = match.guestTeam.getFlagPathURL()
    }
    
    private func setupLocalImage() {
        if let url = localImageURL {
            imageLocal.sd_setImage(with: url) { [weak self] image, error, _, _ in
                if let self = self,
                   let image = image {
                    self.imageLocal.image = image
                    self.imageLocal.image = self.imageLocal.rounded(cornerRadius: 10)
                }
            }
        }
    }
    
    private func setupGuestImage() {
        if let url = guestImageURL {
            imageGuest.sd_setImage(with: url) { [weak self] image, error, _, _ in
                if let self = self,
                   let image = image {
                    self.imageGuest.image = image
                    self.imageGuest.image = self.imageGuest.rounded(cornerRadius: 10)
                }
            }
        }
    }
}
