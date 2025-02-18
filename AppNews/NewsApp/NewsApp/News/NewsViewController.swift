//
//  NewsUIViewController.swift
//  NewsApp
//
//  Created by Иван Курганский on 23/01/2025.
//
import UIKit
import SnapKit

final class NewsViewController: UIViewController {
    //MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()

        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .cream

        return view
    }()
    
    private lazy var contentView = UIView()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()

        view.contentMode = .scaleAspectFit

        return view
    }()

        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var dataOfPublicationLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)

        return label
    }()

    //MARK: - Properties
    private let edgeInset = 10
    private let viewModel: NewsViewModelProtocol

    // MARK: - Life cycle
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
//        self.setupViewModel()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: - Methods
    
    //MARK: - Private methods
    private func setupUI() {
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dataOfPublicationLabel)
        view.addSubview(scrollView)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dataOfPublicationLabel.text = viewModel.date
        
        if let data = viewModel.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "image")
        }

        setupConstraints()
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(imageView.snp.bottom).inset(18)
            make.height.equalTo(view.snp.width)
        }

        dataOfPublicationLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dataOfPublicationLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
            make.bottom.equalToSuperview().inset(edgeInset)
        }
    }
}
