//
//  FeaturesPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import Foundation
import Combine

/*/ FeaturesTabs Presenter Protocol */

protocol  FeaturesTabsPresenterProtocol: AnyObject {
    var view: FeaturesTabsViewProtocol? { get set }
    var router: FeaturesTabsRouterProtocol? { get set }
    
    func bind(input: FeaturesTabsPresenterInput) -> FeaturesTabsPresenterOutput
}

/*/ FeaturesPresenter */

class FeaturesTabsPresenter {
    weak var view: FeaturesTabsViewProtocol?
    var router: FeaturesTabsRouterProtocol?
    var output: FeaturesTabsPresenterOutput = FeaturesTabsPresenterOutput()
    
    private var subscriptions = Set<AnyCancellable>()
}

private extension FeaturesTabsPresenter {
    func getDates() {
        let dates = Defaults.shared.dates
        
        let datesArray = dates.map { date in
            let dateString = String(date.prefix(10))
            let lbl = formatLblDate(dateString: dateString)
            return DataFeature(lblDate: lbl, date: dateString)
        }
        
        output.featuresTabsDataPublisher.send(datesArray)
    }
    
    func formatLblDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        let lblDateFormatter = DateFormatter()
        lblDateFormatter.dateFormat = "MMM d"
        
        return lblDateFormatter.string(from: date ?? Date())
    }
}

extension FeaturesTabsPresenter: FeaturesTabsPresenterProtocol {
    
    func bind(input: FeaturesTabsPresenterInput) -> FeaturesTabsPresenterOutput {
        input.dates.sink { [weak self] in
            self?.getDates()
        }.store(in: &self.subscriptions)
        
        return output
    }
}
