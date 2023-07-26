//
//  TeamTableViewCell.swift
//  FootballChants
//
//  Created by Zehra Coşkun on 18.07.2023.
//

import UIKit

protocol TeamTableViewCellDelegate : class {
    func didTapPlayback(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    
    static let cellID = "TeamTableViewCell"
    
    // MARK: UI
    
    private lazy var containerVw : UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var contentStackVw : UIStackView = {
        let stackVw = UIStackView()
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        stackVw.spacing = 4
        stackVw.axis = .vertical
        return stackVw
    }()
    
    private lazy var badgeImage : UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var playButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private lazy var nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var foundedLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var jobLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 10, weight: .light)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var infoLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .white
        return lbl
    }()
    
    private weak var delegate : TeamTableViewCellDelegate?
    private var team : Team?
    
    //MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        containerVw.layer.cornerRadius = 10
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
        self.delegate = nil
        self.contentView.subviews.forEach{$0.removeFromSuperview()}
    }
    
    func configure(with item : Team, delegate : TeamTableViewCellDelegate){
        self.team = item
        self.delegate = delegate
        
        playButton.addTarget(self, action: #selector(didTapPlayback), for: .touchUpInside)
        
        containerVw.backgroundColor = item.id.background
        badgeImage.image = item.id.badge
        playButton.setImage(item.isPlaying ? Assest.pause : Assest.play, for: .normal)
        nameLabel.text = item.name
        foundedLabel.text = item.founded
        jobLabel.text = "Current \(item.manager.job.rawValue) : \(item.manager.name)"
        infoLabel.text = item.info
        self.contentView.addSubview(containerVw)
        
        containerVw.addSubview(contentStackVw)
        containerVw.addSubview(badgeImage)
        containerVw.addSubview(playButton)
        
        contentStackVw.addArrangedSubview(nameLabel)
        contentStackVw.addArrangedSubview(foundedLabel)
        contentStackVw.addArrangedSubview(jobLabel)
        contentStackVw.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            containerVw.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerVw.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerVw.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 8),
            containerVw.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            badgeImage.heightAnchor.constraint(equalToConstant: 50),
            badgeImage.widthAnchor.constraint(equalToConstant: 50),
            badgeImage.topAnchor.constraint(equalTo: contentStackVw.topAnchor),
            badgeImage.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 8),
            
            contentStackVw.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 16),
            contentStackVw.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -16),
            contentStackVw.leadingAnchor.constraint(equalTo: badgeImage.trailingAnchor, constant: 8),
            contentStackVw.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -8),
            
            playButton.heightAnchor.constraint(equalToConstant: 44),
            playButton.widthAnchor.constraint(equalToConstant: 44),
            playButton.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -8),
            playButton.centerYAnchor.constraint(equalTo: containerVw.centerYAnchor)
        ])
    }
    @objc func didTapPlayback(){
        if let team = team {
            delegate?.didTapPlayback(for: team)
        }
    }
}
