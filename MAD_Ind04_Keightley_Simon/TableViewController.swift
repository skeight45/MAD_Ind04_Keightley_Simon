//
//  TableViewController.swift
//  MAD_Ind04_Keightley_Simon
//
//  Created by Simon Keightley on 4/3/24.
//

struct State {
    var name: String
    var nickname: String
}

import UIKit

class StatesTableViewController: UITableViewController {

    //Array of State structs holding names and nicknames
    let states: [State] = [State]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "US States"
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

