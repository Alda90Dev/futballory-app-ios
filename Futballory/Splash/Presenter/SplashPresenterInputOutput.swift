//
//  SplashPresenterInputOutput.swift
//  Futballory
//
//  Created by Aldair Carrillo on 08/11/23.
//

import Combine

/*/ SplashPresenterInput */

struct SplashPresenterInput {
    let login = PassthroughSubject<Void, Never>()
}

/*/ SplashPresenterOutput */

struct SplashPresenterOutput {
    let splashDataErrorPublisher = PassthroughSubject<Error?, Never>()
}
