//
//  CoinInfoViewController.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//
import UIKit
import RxCocoa
import RxSwift

final class CoinInfoViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = CoinInfoViewModel()
    private let trendCoinlabel = UILabel()
    private let trendNFTLabel = UILabel()
    private let timeLabel = UILabel()
    private var searchbar = UISearchBar()
    
    private lazy var coinCollectionView = UICollectionView(frame: .zero, collectionViewLayout: trendCoinFlowLayout())
    private lazy var nftCollectionView = UICollectionView(frame: .zero, collectionViewLayout: trendNFTFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarAppearance()
        setLeftTitleView(title: C.searchTitle, size: C.large)
        initCollectionView()
        configureSearchbar()
        bind()
    }
    
    private func bind() {
        let output = viewModel.transform()
        
        output.currentTime
            .bind(with: self) { owner, time in
                owner.timeLabel.subtitleLabel(text: time, fontSize: C.medium)
            }
            .disposed(by: disposeBag)
        
        output.trendCoins
            .drive(coinCollectionView.rx.items(
                cellIdentifier: TrendCoinCell.id,
                cellType: TrendCoinCell.self)) { row, item, cell in
                    cell.configureData(item, row)
            }
            .disposed(by: disposeBag)
        
        coinCollectionView.rx.modelSelected(CoinItemDetail.self)
            .bind(with: self, onNext: { owner, model in
                let vc = CoinDetailViewController()
                vc.id.accept(model.id)
                owner.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.trendNFTs
            .drive(nftCollectionView.rx.items(
                cellIdentifier: TrendNFTCell.id,
                cellType: TrendNFTCell.self)) { row, item, cell in
                    cell.configureData(item)
            }
            .disposed(by: disposeBag)
        
        searchbar.rx.searchButtonClicked
            .bind(with: self) { owner, _ in
                owner.searchbar.endEditing(true)
                let vc = TabViewController()
                vc.keyword.accept(owner.searchbar.text ?? "")
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        }
    
    private func initCollectionView() {
        coinCollectionView.register(TrendCoinCell.self, forCellWithReuseIdentifier: TrendCoinCell.id)
        nftCollectionView.register(TrendNFTCell.self, forCellWithReuseIdentifier: TrendNFTCell.id)
    }
    
    private func configureSearchbar() {
        searchbar.searchBarStyle = .minimal
        searchbar.clipsToBounds = true
        searchbar.placeholder = C.placeholder
        
        searchbar.layer.cornerRadius = 20
        searchbar.layer.borderWidth = 1
        searchbar.layer.borderColor = UIColor.darkGray.cgColor
        
        searchbar.searchTextField.borderStyle = .none
        searchbar.searchTextField.font = UIFont.systemFont(ofSize: C.regular)
        searchbar.searchTextField.textColor = UIColor.darkGray
    }
    
    override func configureHierarchy() {
        addSubView(searchbar)
        addSubView(trendCoinlabel)
        addSubView(timeLabel)
        addSubView(coinCollectionView)
        addSubView(trendNFTLabel)
        addSubView(nftCollectionView)
    }
    
    override func configureLayout() {
        searchbar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        trendCoinlabel.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(30)
            make.leading.equalTo(searchbar)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(trendCoinlabel)
            make.trailing.equalTo(searchbar)
        }

        coinCollectionView.snp.makeConstraints { make in
            make.top.equalTo(trendCoinlabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIApplication.shared.getCurrentScene().bounds.height * 0.43)
        }
        
        trendNFTLabel.snp.makeConstraints { make in
            make.top.equalTo(coinCollectionView.snp.bottom)
            make.leading.equalTo(searchbar)
        }
        
        nftCollectionView.snp.makeConstraints { make in
            make.top.equalTo(trendNFTLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(130)
        }
    }
    
    override func configureView() {
        trendCoinlabel.titleLabel(text: C.trendCoin, fontSize: C.regular)
        trendNFTLabel.titleLabel(text: C.trendNFT, fontSize: C.regular)
        nftCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension CoinInfoViewController {
    private func trendCoinFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let verticalInset: CGFloat = 10
        let horizontalInset: CGFloat = 10
        let interitemSpacing: CGFloat = 5
        let numberOfItemsInRow: CGFloat = 2
        let itemHeight: CGFloat = 26
        let screenWidth = UIApplication.shared.getCurrentScene().bounds.width
        let totalHorizontalSpacing = (numberOfItemsInRow - 1) * interitemSpacing + (horizontalInset * 2)
        let itemWidth = (screenWidth - totalHorizontalSpacing) / numberOfItemsInRow
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = verticalInset
        layout.minimumInteritemSpacing = interitemSpacing
        layout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        return layout
    }
    
    private func trendNFTFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 20
        let itemWidth: CGFloat = 72
        let itemHeight: CGFloat = 110
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = inset
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        return layout
    }
}
