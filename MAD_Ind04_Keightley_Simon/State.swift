//
//  State.swift
//  MAD_Ind04_Keightley_Simon
//
//  Created by Simon Keightley on 4/26/24.
//

import Foundation

//struct for the state  information
struct State: Decodable {
    let name: String
    let nickname: String
}

//abstractions to allow for init function
class StateViewModel {
    private let state: State
    
    init(state: State) {
        self.state = state
    }
    
    var name: String {
        state.name
    }
    
    var nickname: String {
        state.nickname
    }
}

//a container for the stateviewmodel that calls the webservice
class StateListViewModel {
    
    private(set) var states: [StateViewModel] = []
    
    func populateStates(url: URL) async {
        do {
            let states = try await WebService().getStates(url: url)
            self.states = states.map(StateViewModel.init)
        } catch {
            print(error)
        }
    }
}
