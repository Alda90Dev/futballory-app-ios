//
//  TeamsPresenterInputOutput.swift
//  Futballory
//
//  Created by Aldair Carrillo on 22/11/23.
//

import Foundation
import Combine

/*/ TeamsPresenterInput */

struct TeamsPresenterInput {
    let teams = PassthroughSubject<Void, Never>()
}

/*/ TeamsPresenterOutput */

struct TeamsPresenterOutput {
    let teamsDataErrorPublisher = PassthroughSubject<Result<[Team], Error>, Never>()
}
