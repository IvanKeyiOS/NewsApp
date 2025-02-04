//
//  BusinessViewController.swift
//  NewsApp
//
//  Created by Иван Курганский on 19/01/2025.
//

import UIKit

final class BusinessViewController: UIViewController {
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
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    //MARK: - Properties
    
    
    // MARK: - Life cycle
//    init(businessViewModel: BusinessViewModelProtocol) {
//        self.businessViewModel = businessViewModel
//        super.init(nibName: nil, bundle: nil)
//        self.setupBusinessViewModel()
//        
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        collectionView.register(GeneralCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        
        collectionView.register(BusinessCollectionViewCell.self,
                                forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        
    }
    //MARK: - Methods
    
    //MARK: - Private methods
    private func setupBusinessViewModel() {
//        businessViewModel.reloadData = { [weak self] in
//            self?.collectionView.reloadData()
//        }
//        
//        businessViewModel.reloadCell = { [weak self] row in
//            self?.collectionView.reloadItems(at: [IndexPath(row: row,
//                                                            section: 0)])
//            
//        }
//        
//        businessViewModel.showError = { error in
//            //TODO: show alert with error
//            print(error)
//        }
    }
    
    
    private func setupUI() {

        view.backgroundColor = .white
        view.addSubview(collectionView)
        
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
extension BusinessViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : 15
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessCollectionViewCell",
                                                      for: indexPath) as? BusinessCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell",
                                                      for: indexPath) as? BusinessCollectionViewCell
        }
//        let article = businessViewModel.getArticle(for: indexPath.row)
//        cell.set(article: article)
////        print(#function)
//        return cell
        
        return cell ?? UICollectionViewCell()
    }
}
//MARK: - UICollectionViewDelegate
extension BusinessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
//        let detailViewController = DetailUIViewController()
//        navigationController?.pushViewController(detailViewController,
//                                                 animated: true)
//        let article = businessViewModel.getArticle(for: indexPath.row)
//        navigationController?.pushViewController(BusinessUIViewController(businessViewModel: BusinessViewModel(article: businessArticle)),
//                                                 animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let firstSectionSize = CGSize(width: width, height: width)
        let secondSectionSize = CGSize(width: width, height: 100)
        
        return indexPath.section == 0 ? firstSectionSize : secondSectionSize
    }
}
