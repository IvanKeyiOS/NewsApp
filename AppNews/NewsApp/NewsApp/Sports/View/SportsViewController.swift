//
//  SportsViewController.swift
//  NewsApp
//
//  Created by Иван Курганский on 08/02/2025.
//

import UIKit

final class SportsViewController: UIViewController {
    //MARK: - GUI Variables
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
//        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20,
                                           left: 20,
                                           bottom: 20,
                                           right: 20)
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height),
                                                            collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
       
        return collectionView
    }()
    
    //MARK: - Properties
    private var viewModel: SportsViewModelProtocol
    
    // MARK: - Life cycle
    init(viewModel: SportsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView.register(GeneralCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        
        collectionView.register(SportsCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SportsCollectionViewCell")
        viewModel.loadData()
    }
    
    //MARK: - Private methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row,
                                                            section: 0)])
        }
        
        viewModel.showError = { error in
            //TODO: show alert with error
            print(error)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .cream
        view.addSubview(collectionView)
        collectionView.backgroundColor = .cream
        
        setupConstraints()
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension SportsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfCells > 1 ? 2 : 1
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if viewModel.numberOfCells > 1 {
            return section == 0 ? 1 : viewModel.numberOfCells - 1
        }
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell",
                                                      for: indexPath) as? GeneralCollectionViewCell
                    let article = viewModel.getArticle(for: 0)
            cell?.set(article: article)
                    print(#function)
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCollectionViewCell",
                                                      for: indexPath) as? SportsCollectionViewCell
            let article = viewModel.getArticle(for: indexPath.row + 1)
            cell?.set(article: article)
            
            return cell ?? UICollectionViewCell()
        }
    }
}
//MARK: - UICollectionViewDelegate
extension SportsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.getArticle(for: indexPath.section == 0 ? 0 : indexPath.row + 1)
        navigationController?.pushViewController(NewsViewController(viewModel: NewsViewModel(article: article)),
                                                 animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SportsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let firstSectionSize = CGSize(width: width, height: width)
        let secondSectionSize = CGSize(width: width, height: 100)
        
        return indexPath.section == 0 ? firstSectionSize : secondSectionSize
    }
}
