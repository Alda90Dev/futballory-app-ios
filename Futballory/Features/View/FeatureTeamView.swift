//
//  FeatureTeamView.swift
//  Futballory
//
//  Created by Aldair Carrillo on 15/11/23.
//

import UIKit
import SDWebImage

class FeatureTeamView: UIView {
    
    private lazy var imgFlag: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var lblTeam: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var lblScore: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private var imgFlagURL: URL? {
        didSet {
            setupImageFlag()
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
        addSubview(imgFlag)
        addSubview(lblTeam)
        addSubview(lblScore)
        
        NSLayoutConstraint.activate([
            imgFlag.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imgFlag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imgFlag.widthAnchor.constraint(equalToConstant: 35),
            imgFlag.heightAnchor.constraint(equalToConstant: 22),
            
            lblTeam.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            lblTeam.leadingAnchor.constraint(equalTo: imgFlag.trailingAnchor, constant: 8),
            lblTeam.trailingAnchor.constraint(equalTo: lblScore.leadingAnchor, constant: -8),
            lblTeam.heightAnchor.constraint(equalToConstant: 22),
            
            lblScore.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            lblScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            lblScore.widthAnchor.constraint(equalToConstant: 35),
            lblScore.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configure(flag: URL?, team: String?, score: String?) {
        lblTeam.text = team
        lblScore.text = score
        imgFlagURL = flag
    }
    
    private func setupImageFlag() {
        if let url = imgFlagURL {
            imgFlag.sd_setImage(with: url, placeholderImage: ImageCatalog.iconPlaceholderFlag) { [weak self] image, error, _, _ in
                    if let self = self,
                       let image = image {
                        self.imgFlag.image = image
                        //self.imgFlag.image = self.imgFlag.rounded(cornerRadius: 5)
                    }
            }
        }
    }
}
