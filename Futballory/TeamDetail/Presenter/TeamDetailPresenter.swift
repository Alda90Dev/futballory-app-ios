//
//  TeamDetailPresenter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import Foundation
import Combine

/*/ TeamDetailPresenter Protocol */

protocol TeamDetailPresenterProtocol: AnyObject {
    var view: TeamDetailViewProtocol? { get set }
    var interactor: TeamDetailInteractorInputProtocol? { get set }
    var router: TeamDetailRouterProtocol? { get set }
    
    func bind(input: TeamDetailPresenterInput) -> TeamDetailPresenterOutput
}

/*/ TeamDetailPresenter */

class TeamDetailPresenter {
    weak var view: TeamDetailViewProtocol?
    var interactor: TeamDetailInteractorInputProtocol?
    var router: TeamDetailRouterProtocol?
    var output: TeamDetailPresenterOutput = TeamDetailPresenterOutput()

    private var team: Team
    private var subscriptions = Set<AnyCancellable>()
    
    init(team: Team) {
        self.team = team
    }
}

extension TeamDetailPresenter: TeamDetailPresenterProtocol {
    func bind(input: TeamDetailPresenterInput) -> TeamDetailPresenterOutput {
        input.players.sink { [weak self] in
            guard let self = self else { return }
            self.interactor?.getPlayers(team: self.team.id)
        }.store(in: &subscriptions)
        
        input.teamData.sink { [weak self] in
            guard let self = self else { return }
            self.output.teamDataPublisher.send((team.name, team.getFlagPathURL()))
        }.store(in: &subscriptions)
        
        return output
    }
}

extension TeamDetailPresenter: TeamDetailInteractorOutputProtocol {
    func interactorGetDataPresenter(receivedData: PlayersResponse?, error: Error?) {
        if let error = error {
            output.playersDataErrorPublisher.send(.failure(error))
        } else if let response = receivedData,
                  response.success {

            var teamPlayers: [TeamPlayers] = []
            let players = response.players.filter({ $0.playerType == .player })
            let coach = response.players.filter({ $0.playerType == .coach })
            
            teamPlayers.append(TeamPlayers(playerType: .player, players: players))
            teamPlayers.append(TeamPlayers(playerType: .coach, players: coach))
            output.playersDataErrorPublisher.send(.success(teamPlayers))
        }
    }
}
