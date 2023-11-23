//
//  GroupsPresenterInputOutput.swift
//  Futballory
//
//  Created by Aldair Carrillo on 16/11/23.
//

import Foundation
import Combine

/*/ GroupsPresenterInput */

struct GroupsPresenterInput {
    let groups = PassthroughSubject<Void, Never>()
}

/*/ GroupsPresenterOutput */

struct GroupsPresenterOutput {
    let groupsDataErrorPublisher = PassthroughSubject<Result<[Group], Error>, Never>()
}
