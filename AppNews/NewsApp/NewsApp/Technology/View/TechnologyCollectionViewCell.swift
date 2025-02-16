//
//  TechnologyCollectionViewCell.swift
//  NewsApp
//
//  Created by Иван Курганский on 08/02/2025.
//

import UIKit
import SnapKit

final class TechnologyCollectionViewCell: UICollectionViewCell {
    //MARK: - GUI Variables
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label  = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Title here"
        label.numberOfLines = 2
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Then, the two-year mission will officially begin."
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //MARK: - Methods
    func set(article: ArticleCellViewModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.title
        
        if let data = article.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "image")
        }
    }
    private func setupUI() {
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(self.frame.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
}

