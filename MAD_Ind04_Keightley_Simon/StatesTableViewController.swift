//
//  TableViewController.swift
//  MAD_Ind04_Keightley_Simon
//
//  Created by Simon Keightley on 4/3/24.
//

import UIKit

class StatesTableViewController: UITableViewController {

    @IBOutlet var spinner: UIActivityIndicatorView!
    
    //Array of State structs holding names and nicknames
    let viewModel = StateListViewModel()
    var statesList: [StateViewModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "US States"
        
        //self.dataSource = self
        //self.delegate = self
        
        //set the spinner to start animating and hide when it is stopped later
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        //task to allow for async methods to be run in viewDidLoad, which is not async
        Task {
            await populateStates()
            
            if statesList[0].name == "Alabama" {
                print("data read success")
            } else {
                print("data read fail")
            }
            
            //testing a delay to prove the spinner exists
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            //stops the spinner
            spinner.stopAnimating()
        }
        
    }
    
    //sets up a chain to populate the states later down the line using my php url
    private func populateStates() async {
        print("enters top-level populateStates")
        let statesURL = URL(string: "https://cs.okstate.edu/~skeight/index.php")
        await viewModel.populateStates(url: statesURL!)
        statesList = viewModel.states
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //only implement 1 section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesList.count
    }

    //Configures table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("enters cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        let state = statesList[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.nickname
        return cell
    }
    
    //Segues to a selected state when tapping on a cell -- not needed ind04
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedState = statesList[indexPath.row]
        //performSegue(withIdentifier: "showStateDetail", sender: selectedState)
    }
    */
     

}

