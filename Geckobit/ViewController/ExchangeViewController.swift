//
//  ViewController.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import UIKit
import RxCocoa
import RxSwift

final class ExchangeViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private let buttonTapped = PublishRelay<Int>()
    private let viewModel = ExchangeViewModel()
    private let headerView = ContainerView(backgroundColor: .customLightgray)
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarAppearance()
        setLeftTitleView(title: C.exchangeTitle, size: C.large)
        initTableView()
        bind()
    }
    
    override func configureHierarchy() {
        addSubView(headerView)
        addSubView(tableView)
    }
    
    override func configureLayout() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func initTableView() {
        tableView.separatorStyle = .none
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.id)
    }
    
    private func bind() {
        let input = ExchangeViewModel.Input(columnTapped: buttonTapped)
        let output = viewModel.transform(input: input)
        
        output.headers
            .drive(with: self, onNext: { owner, items in
                for item in items {
                    let column = FilterView()
                    
                    if item.isFilter {
                        column.configureData(title: item.title, tag: item.tag)
                    } else {
                        column.configureData(title: item.title, tag: item.tag, isNotFilter: true)
                    }
                    
                    owner.headerView.addArrangedSubview(column)
                }
                
                Observable.merge(
                    owner.headerView.arrangedSubviews
                        .compactMap { $0 as? FilterView }
                        .map { view in
                            view.button.rx.tap.map { view.button.tag }
                        }
                )
                .bind(to: owner.buttonTapped)
                .disposed(by: owner.disposeBag)
            })
            .disposed(by: disposeBag)
        
        output.column
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, state in
                let filterViews = owner.headerView.arrangedSubviews.compactMap { $0 as? FilterView }
                filterViews.forEach { $0.initArrow() }
                
                guard let selectedFilterView = filterViews.first(where: { $0.button.tag == state.column.rawValue }) else { return }
                selectedFilterView.changeArrowColor(status: state.sort)
            }
            .disposed(by: disposeBag)
        
        output.coins
            .drive(tableView.rx.items(
                cellIdentifier: CoinTableViewCell.id,
                cellType: CoinTableViewCell.self)) { row, coin, cell in
                    cell.selectionStyle = .none
                    cell.configureData(coin)
                }
                .disposed(by: disposeBag)
    }
}

