//
//  FeaturesTabsPresenterInputOutput.swift
//  Futballory
//
//  Created by Aldair Carrillo on 13/11/23.
//

import Foundation
import Combine
import UIKit

/*/ FeaturesTabsPresenterInput */

struct FeaturesTabsPresenterInput {
    let dates = PassthroughSubject<Void, Never>()
}

/*/ FeaturesPresenterOutput */
 
struct FeaturesTabsPresenterOutput {
    let featuresTabsDataPublisher = PassthroughSubject<[DataFeature], Never>()
}

/*/ Struct Data Feature */

struct DataFeature {
    let lblDate: String
    let date: String
}
