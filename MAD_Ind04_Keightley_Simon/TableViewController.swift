//
//  TableViewController.swift
//  MAD_Ind04_Keightley_Simon
//
//  Created by Simon Keightley on 4/3/24.
//

import UIKit

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

class StatesTableViewController: UITableViewController {

    //Array of State structs holding names and nicknames
    private(set) var states: [StateViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "US States"
        
    }
    
    func populateStates(url: URL) async {
        
        do {
            let states = try await WebService().getStates(url: url)
            self.states = states.map(StateViewModel.init)
        } catch {
            print(error)
        }
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //only implement 1 section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }

    //Configures table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.nickname
        return cell
    }
    
    //Segues to a selected state when tapping on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedState = states[indexPath.row]
        performSegue(withIdentifier: "showStateDetail", sender: selectedState)
    }

}

