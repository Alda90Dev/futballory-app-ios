//
//  MainPresenterInputOutput.swift
//  Futballory
//
//  Created by Aldair Carrillo on 09/11/23.
//

import Foundation
import Combine

/*/ MainPresenterInput */

struct MainPresenterInput {
    let matches = PassthroughSubject<Void, Never>()
}

/*/ MainPresenterOutput */

struct MainPresenterOutput {
    let mainDataErrorPublisher = PassthroughSubject<Result<[Match], Error>, Never>()
}
