//
//  CoinDetailViewController.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit
import RxCocoa
import RxSwift
import DGCharts

final class CoinDetailViewController: BaseViewController {
    var id = BehaviorRelay<String>(value: "")
    
    private let disposeBag = DisposeBag()
    private let viewModel = CoinDetailViewModel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let currentPirce = UILabel()
    private let arrowView = ArrowPercentView()
    private let timeView = UILabel()
    private let infoView = UILabel()
    private let moreInfo = MoreButton()
    private let priceInfo = PriceInfoView()
    private let investmentLabel = UILabel()
    private let moreInvestment = MoreButton()
    private let investmentView = InvestmentView()
    
    private var chartView = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarAppearance()
        configureBackButton()
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(currentPirce)
        contentView.addSubview(arrowView)
        contentView.addSubview(chartView)
        contentView.addSubview(timeView)
        contentView.addSubview(infoView)
        contentView.addSubview(moreInfo)
        contentView.addSubview(priceInfo)
        contentView.addSubview(investmentLabel)
        contentView.addSubview(moreInvestment)
        contentView.addSubview(investmentView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        currentPirce.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).inset(10)
        }
        
        arrowView.snp.makeConstraints { make in
            make.top.equalTo(currentPirce.snp.bottom).offset(5)
            make.leading.equalTo(currentPirce)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(arrowView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.width).dividedBy(2)
        }
        
        timeView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(5)
            make.leading.equalTo(currentPirce)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(20)
            make.leading.equalTo(timeView)
        }
        
        moreInfo.snp.makeConstraints { make in
            make.centerY.equalTo(infoView)
            make.trailing.equalTo(contentView).inset(10)
        }
        
        priceInfo.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        investmentLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoView)
            make.top.equalTo(priceInfo.snp.bottom).offset(20)
        }
        
        moreInvestment.snp.makeConstraints { make in
            make.centerY.equalTo(investmentLabel)
            make.trailing.equalTo(contentView).inset(10)
        }
        
        investmentView.snp.makeConstraints { make in
            make.top.equalTo(investmentLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.bottom.equalTo(contentView).inset(20)
        }
    }
    
    override func configureView() {
        configureChart()
        infoView.titleLabel(text: C.coinInfo, fontSize: C.regular)
        investmentLabel.titleLabel(text: C.indicator, fontSize: C.regular)
    }
    
    private func bind() {
        let input = CoinDetailViewModel.Input(id: id)
        let output = viewModel.transform(input: input)
        let titleView = ImageTitleView()
        
        output.detail
            .compactMap { $0.first }
            .drive(with: self) { owner, response in
                owner.configureBookmarkButton(response.name)
                titleView.configureData(response.image, response.symbol)
                owner.navigationItem.titleView = titleView
                owner.currentPirce.wonLabel(data: response.current_price, isBig: true)
                owner.arrowView.configureButton(response.price_change_percentage_24h)
                owner.setLineData(owner.chartView, owner.entryData(values: response.sparkline_in_7d.price), "")
                owner.timeView.subtitleLabel(text: Date().iso8601ToString(data: response.last_updated, format: C.detailFormat), fontSize: C.small)
                owner.priceInfo.configure(high24h: response.high_24h, low24h: response.low_24h, ath: response.ath, athDate: response.ath_date, atl: response.atl, atlDate: response.atl_date)
                owner.investmentView.configure(marketCap: response.market_cap, fdv: response.fully_diluted_valuation, volume: response.total_volume)
            }
            .disposed(by: disposeBag)
        
        output.tooManyError
            .drive(with: self) { owner, result in
                if result {
                    owner.popAlert(message: C.tooManyRequests)
                }
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
    
    private func configureBookmarkButton(_ id: String) {
        let bookmarkButton = BookMarkView()
        bookmarkButton.configureButton(id)
        configureRightBarButtonItem(view: bookmarkButton)
    }
}

extension CoinDetailViewController {
    private func configureChart() {
        chartView.noDataText = "No Data"
        chartView.noDataFont = .systemFont(ofSize: 20)
        chartView.noDataTextColor = .lightGray
        
        chartView.isUserInteractionEnabled = false
        
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        
        chartView.legend.enabled = false
        chartView.drawBordersEnabled = false
        
        chartView.backgroundColor = .white
    }
    
    private func setLineData(_ lineChartView: LineChartView, _ lineChartDataEntries: [ChartDataEntry], _ text: String) {
        let lineChartdataSet = LineChartDataSet(entries: lineChartDataEntries, label: text)
        lineChartdataSet.drawValuesEnabled = false
        lineChartdataSet.drawCirclesEnabled = false
        lineChartdataSet.colors = [.customBlue]
        
        let colorTop = lineChartdataSet.colors[0].withAlphaComponent(1.0).cgColor
        let colorBottom = lineChartdataSet.colors[0].withAlphaComponent(0.1).cgColor
        
        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        
        lineChartdataSet.fill = LinearGradientFill(gradient: gradient!, angle: 90.0)
        lineChartdataSet.drawFilledEnabled = true
        lineChartdataSet.fillAlpha = 1.0
        
        let lineChartData = LineChartData(dataSet: lineChartdataSet)
        lineChartView.data = lineChartData
    }
    
    private func entryData(values: [Double]) -> [ChartDataEntry] {
        var lineDataEntries: [ChartDataEntry] = []
        
        for i in 0 ..< values.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            lineDataEntries.append(lineDataEntry)
        }
        
        return lineDataEntries
    }
}
