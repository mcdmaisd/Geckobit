//
//  SearchCoinViewController.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchCoinViewController: BaseViewController {
    var keyword = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    private let viewModel = SearchCoinViewModel()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: singleColumnFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let index = U.shared.get(C.cellKey, -1)
        if index != -1 {
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            U.shared.set(-1, C.cellKey)
        }
    }
    
    override func configureHierarchy() {
        addSubView(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        initCollectionView()
    }
    
    private func initCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    private func bind() {
        let input = SearchCoinViewModel.Input(keyword: keyword)
        let output = viewModel.transform(input: input)
        
        output.coins
            .drive(collectionView.rx.items(
                cellIdentifier: SearchResultCollectionViewCell.id,
                cellType: SearchResultCollectionViewCell.self)) { row, item, cell in
                    cell.configureData(item)
                    
                }
                .disposed(by: disposeBag)
        
        output.scrollToTop
            .drive(with: self, onNext: { owner, result in
                if result { owner.collectionView.scrollToItem(at: IndexPath(row: -1, section: 0), at: .top, animated: false)}
            })
            .disposed(by: disposeBag)
        
        Observable.zip(
            collectionView.rx.modelSelected(SearchResult.self),
            collectionView.rx.itemSelected
        )
        .bind(with: self) { owner, tuple in
            let (model, indexPath) = tuple
            
            U.shared.set(indexPath.item, C.cellKey)
            
            let vc = CoinDetailViewController()
            vc.id.accept(model.id)
            owner.navigationController?.pushViewController(vc, animated: true)
        }
        .disposed(by: disposeBag)
    }
}

extension SearchCoinViewController {
    private func singleColumnFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 20
        let screenWidth = UIApplication.shared.getCurrentScene().bounds.width
        let itemWidth = screenWidth - (inset * 2)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: 36)
        layout.minimumLineSpacing = inset
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        return layout
    }
}
