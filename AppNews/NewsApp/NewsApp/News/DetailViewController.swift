//
//  DetailUIViewController.swift
//  NewsApp
//
//  Created by Иван Курганский on 23/01/2025.
//

import UIKit
import SnapKit

class DetailUIViewController: UIViewController {
    
    //MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage.add
//        UIImage(named: "image") ??
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
        
        label.text = "CNN"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "\tNASA's planet-hunting satellite TESS launches. CNN — TESS, NASA’s planet-hunting satellite, launched on a SpaceX Falcon 9 rocket from Cape Canaveral, Florida, at 6:51 p.m. ET Wednesday. It had a 30-second launch window. The launch was originally scheduled for Monday, but rescheduled to conduct additional Guidance Navigation and Control analysis, the agency said. \n\n\tThe first stage of the Falcon 9 rocket was able to land on the droneship minutes later. \n\n\tThe Transiting Exoplanet Survey Satellite is NASA’s next mission in the search for exoplanets, or those that are outside our solar system, and TESS will be on the lookout for planets that could support life. \n\n\tAfter launch, TESS will use its fuel to reach orbit around the Earth, with a gravity assist from the moon. That will enable it to have a long-term mission beyond its two-year objective. “The Moon and the satellite are in a sort of dance,” Joel Villasenor, instrument scientist for TESS at the Massachusetts Institute of Technology, said in a statement. “The Moon pulls the satellite on one side, and by the time TESS completes one orbit, the Moon is on the other side tugging in the opposite direction. The overall effect is the Moon’s pull is evened out, and it’s a very stable configuration over many years. Nobody’s done this before, and I suspect other programs will try to use this orbit later on.” \n\n\tOver 60 days, TESS will establish an orbit around Earth and test its instruments. Then, the two-year mission will officially begin."
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var dataOfPublicationLabel: UILabel = {
        let label = UILabel()
        
        label.text = "23.01.2025"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    //MARK: - Properties
    
    private let edgeInset = 10
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupUI()
    }
    //MARK: - Methods
    
    //MARK: - Private methods
    private func setupUI() {
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(blackView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dataOfPublicationLabel)
        view.addSubview(scrollView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        dataOfPublicationLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        blackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(imageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(blackView.snp.top).inset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dataOfPublicationLabel.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
            make.bottom.equalToSuperview().inset(edgeInset)
        }
    }
        
    //MARK: - UICollectionViewDataSource
    
    //MARK: - UICollectionViewDelegate
}
