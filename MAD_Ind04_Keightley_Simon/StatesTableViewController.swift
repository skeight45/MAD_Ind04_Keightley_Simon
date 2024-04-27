//
//  TableViewController.swift
//  MAD_Ind04_Keightley_Simon
//
//  Created by Simon Keightley on 4/3/24.
//

import UIKit

class StatesTableViewController: UITableViewController {

    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var tableOfStates: UITableView!
    
    //Array of State structs holding names and nicknames
    var viewModel = StateListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "US States"
        
        //set the spinner to start animating and hide when it is stopped later
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        //task to allow for async methods to be run in viewDidLoad, which is not async
        Task {
            await populateStates()
            
            //testing a delay to prove the spinner exists
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            //stops the spinner
            spinner.stopAnimating()
        }
        
        tableOfStates.dataSource = self
        tableOfStates.delegate = self
        
    }
    
    //sets up a chain to populate the states later down the line using my php url
    private func populateStates() async {
        //print("enters top-level populateStates")
        let statesURL = URL(string: "https://cs.okstate.edu/~skeight/index.php")
        await viewModel.populateStates(url: statesURL!)
        //this is necessary to reload data through the referencing outlet
        DispatchQueue.main.async {
            self.tableOfStates.reloadData()
        }
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //only implement 1 section
        //print("enters numberOfSections")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("enters numberOfRowsInSection")
        return viewModel.states.count
    }

    //Configures table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("enters cellForRowAt")
        var cell = tableView.dequeueReusableCell(withIdentifier: "StateCell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "StateCell")
        cell?.textLabel?.text = viewModel.states[indexPath.row].name
        cell?.detailTextLabel?.text = viewModel.states[indexPath.row].nickname
        return cell!
    }
    
    //Segues to a selected state when tapping on a cell -- not needed ind04
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedState = statesList[indexPath.row]
        //performSegue(withIdentifier: "showStateDetail", sender: selectedState)
    }
    */
     

}

