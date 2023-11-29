//
//  StadiumViewCell.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import UIKit
import SDWebImage

class StadiumViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: StadiumViewCell.self)

    private lazy var viewContainer: UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var viewLabel: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .lightGray
        stack.spacing = 8
        return stack
    }()
    
    private lazy var lblStadium: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.backgroundColor = .lightGray
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    private lazy var imgStadium: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private var imgURL: URL? {
        didSet {
            setupStadiumImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        viewLabel.addArrangedSubview(lblStadium)
        
        viewContainer.addSubview(imgStadium)
        viewContainer.addSubview(viewLabel)
        
        contentView.addSubview(viewContainer)
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            viewContainer.heightAnchor.constraint(equalToConstant: 175),
            
            imgStadium.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            imgStadium.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            imgStadium.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            imgStadium.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            
            
            viewLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            viewLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            viewLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            viewLabel.heightAnchor.constraint(equalToConstant: 30),
            
            lblStadium.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: 8)
        ])
    }
    
    func config(_ stadium: Stadium) {
        lblStadium.text = stadium.name
        imgURL = stadium.getPhotoPathURL()
    }

    private func setupStadiumImage() {
        if let url = imgURL {
            imgStadium.sd_setImage(with: url) { [weak self] image, error, _, _ in
                self?.imgStadium.image = image
            }
        }
    }
}
