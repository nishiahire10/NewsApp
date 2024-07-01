//
//  NewsTableViewCell.swift
//  News App
//
//  Created by Nishigandha Bhushan Jadhav on 01/07/24.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "News"
    
    let imgView = UIImageView()
    let newstitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        [imgView,newstitleLabel] .forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacing),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacing),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset),
            imgView.widthAnchor.constraint(equalToConstant: Layout.placeholderSize.width),
            newstitleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: Layout.offset),
            newstitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacing),
        ])
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        selectionStyle = .none
        newstitleLabel.font = .systemFont(ofSize: 15)
    }
    
}
