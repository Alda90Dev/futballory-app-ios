//
//  TeamsPresenterInputOutput.swift
//  Futballory
//
//  Created by Aldair Carrillo on 23/11/23.
//

import Foundation
import Combine

/*/ StadiumsPresenterInput */

struct StadiumsPresenterInput {
    let stadiums = PassthroughSubject<Void, Never>()
}

/*/ StadiumsPresenterOutput */

struct StadiumsPresenterOutput {
    let stadiumsDataErrorPublisher = PassthroughSubject<Result<[Stadium], Error>, Never>()
}
