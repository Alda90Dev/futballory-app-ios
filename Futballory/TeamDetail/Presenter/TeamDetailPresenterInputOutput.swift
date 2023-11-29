//
//  TeamDetailPresenterInputOutput.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import Foundation
import Combine

/*/ TeamDetailPresenterInput */

struct TeamDetailPresenterInput {
    let players = PassthroughSubject<Void, Never>()
}

/*/ TeamDetailPresenterOutput */

struct TeamDetailPresenterOutput {
    let playersDataErrorPublisher = PassthroughSubject<Result<[Player], Error>, Never>()
}
