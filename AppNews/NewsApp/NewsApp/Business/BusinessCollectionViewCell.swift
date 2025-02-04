//
//  DetailsCollectionViewCell.swift
//  NewsApp
//
//  Created by Иван Курганский on 25/01/2025.
//

import UIKit
import SnapKit

final class BusinessCollectionViewCell: UICollectionViewCell {
    //MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
//        view.image = UIImage(named: "image") ?? UIImage.add
        view.contentMode = .scaleAspectFill
        //закомментировать потом
//        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Title here"
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
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
    
    //MARK: - Methods
//    func set(businessArticle: BusinessArticleCellViewModel) {
//        titleLabel.text = businessArticle.title
//        
//        if let data = businessArticle.imageData,
//           let image = UIImage(data: data) {
//            imageView.image = image
//        } else {
//            imageView.image = UIImage(named: "image")
//        }
//    }
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
