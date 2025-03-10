//
//  TabmanViewController.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit
import Tabman
import Pageboy
import RxCocoa
import RxSwift

final class TabViewController: TabmanViewController {
    var keyword = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    private let firstVC = SearchCoinViewController()
    private let secondVC = NFTViewController()
    private let thirdVC = EmptyExchangeViewController()
    private var searchBar = UISearchBar()
    private lazy var viewControllers = [firstVC, secondVC, thirdVC]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchbar()
        configureBackButton()
        configureTab()
        bind()
    }
    
    private func configureSearchbar() {
        searchBar.placeholder = C.placeholder
        searchBar.searchTextField.leftView = nil
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.clearButtonMode = .never
        
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
        
    private func bind() {
        Observable.merge(
            keyword.map { $0 },
            searchBar.rx.searchButtonClicked
                .withUnretained(self)
                .map { owner, _ in
                    owner.searchBar.text ?? ""
                }
        )
        .bind(with: self) { owner, keyword in
            owner.searchBar.text = keyword
            let vc = owner.firstVC
            vc.keyword.accept(keyword)
        }
        .disposed(by: disposeBag)
    }
    
    private func configureBackButton() {
        let backButtonView = BackButtonView()
        
        backButtonView.button.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        configureLeftBarButtonItem(view: backButtonView)
    }
    
    private func configureTab() {
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.indicator.weight = .medium
        bar.indicator.tintColor = .black
        bar.buttons.customize { button in
            button.selectedTintColor = .black
            button.tintColor = .gray
            button.font = UIFont.systemFont(ofSize: C.regular, weight: .bold)
        }
        
        addBar(bar, dataSource: self, at: .top)
    }
}

extension TabViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
}

extension TabViewController: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: C.upperTabbarTitles[index])
    }
}
