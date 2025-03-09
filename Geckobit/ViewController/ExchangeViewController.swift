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
    private let viewModel = ExchangeViewModel()
    private let headerView = ContainerView(backgroundColor: .customLightgray)
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarAppearance()
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
    
    override func configureView() {
        configureHeaderView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: TitleView(title: C.exchangeTitle))
    }
    
    private func initTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.id)
    }
    
    private func configureHeaderView() {
        for (i, title) in C.columnTitle.enumerated() {
            let column = FilterView()
            
            if title == C.coin {
                column.configureData(title: title, tag: i, true)
            } else {
                column.configureData(title: title, tag: i)
            }
            
            headerView.addArrangedSubview(column)
        }
    }
    
    private func bind() {
        let columnTapped = Observable.merge(
            headerView.arrangedSubviews
                .compactMap { $0 as? FilterView }
                .map { view in
                    view.button.rx.tap.map { view.button.tag }
                })
        let input = ExchangeViewModel.Input(columnTapped: columnTapped)
        let output = viewModel.transform(input: input)
        
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

