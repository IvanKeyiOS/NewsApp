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
    private lazy var imageView: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(named: "image") ?? UIImage.add

        return view
    }()

    private lazy var blackView: UIView = {
        let view = UIView()

        view.backgroundColor = .black
        view.alpha = 0.5

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.text = "Title"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)

        return label
    }()

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

        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }

        blackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.height.equalTo(20)
            make.leading.trailing.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(blackView)
            make.leading.trailing.equalTo(blackView).offset(5)
        }
    }
}
