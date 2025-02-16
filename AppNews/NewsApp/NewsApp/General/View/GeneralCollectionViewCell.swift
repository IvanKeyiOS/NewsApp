//
//  GeneralCollectionViewCell.swift
//  NewsApp
//
//  Created by Иван Курганский on 22/01/2025.
//

import UIKit
import SnapKit

final class GeneralCollectionViewCell: UICollectionViewCell {
    
    //MARK: - GUI Variables
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        view.clipsToBounds = true
//        view.layer.masksToBounds = true

        return view
    }()
    
    private let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        
        view.clipsToBounds = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    //MARK: - Properties
//    static let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func set(article: ArticleCellViewModel) {
        titleLabel.text = article.title
        
        if let data = article.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "image")
        }
    }
    
    //MARK: - Private methods
    private func setupUI() {
        addSubview(imageView)
        addSubview(blackView)
        addSubview(titleLabel)
//        addSubview(GeneralCollectionViewCell.activityIndicator)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
//        GeneralCollectionViewCell.activityIndicator.snp.makeConstraints { make in
//            make.centerX.equalTo(imageView.snp.centerX)
//            make.centerY.equalTo(imageView.snp.centerY)
//        }
        
        blackView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(blackView)
            make.leading.trailing.equalTo(blackView).offset(5)
        }
    }
}
