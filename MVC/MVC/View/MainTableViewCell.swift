//
//  MainTableViewCell.swift
//  MVC
//
//  Created by hy_sean on 17/01/2019.
//  Copyright © 2019 hy_sean. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
  
  lazy var avatarView: UIImageView = {
    let iv = UIImageView()
    iv.layer.cornerRadius = 30
    iv.clipsToBounds = true
    iv.backgroundColor = .black
    return iv
  }()
  
  lazy var verticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    return stackView
  }()
  
  lazy var repoTitleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
    return label
  }()
  
  lazy var languageLabel: UILabel = {
    let label = UILabel()
    label.text = "Swift"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
    return label
  }()
  
  lazy var horizonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.alignment = .center
    return stackView
  }()
  
  lazy var starsLabel: UILabel = {
    let label = UILabel()
    label.text = "Star : "
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    return label
  }()
  
  lazy var updateDateLabel: UILabel = {
    let label = UILabel()
    label.text = "update : "
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    label.textAlignment = .right
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(avatarView)
    addSubview(verticalStackView)
    addSubview(horizonStackView)
    
    [repoTitleLabel, languageLabel].forEach { label in
      verticalStackView.addArrangedSubview(label)
    }
    
    [starsLabel, updateDateLabel].forEach { label in
      horizonStackView.addArrangedSubview(label)
    }
    
    avatarView.anchor(top: topAnchor,
                      leading: safeAreaLayoutGuide.leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: nil,
                      padding: .init(top: 12, left: 12, bottom: 12, right: 0),
                      size: .init(width: 60, height: 60))
    
    verticalStackView.anchor(top: topAnchor,
                     leading: avatarView.trailingAnchor,
                     bottom: nil,
                     trailing: trailingAnchor,
                     padding: .init(top: 16, left: 8, bottom: 0, right: 8),
                     size: .init(width: 0, height: 30))
    
    horizonStackView.anchor(top: verticalStackView.bottomAnchor,
                            leading: avatarView.trailingAnchor,
                            bottom: bottomAnchor,
                            trailing: safeAreaLayoutGuide.trailingAnchor,
                            padding: .init(top: 8, left: 8, bottom: 16, right: 16))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
