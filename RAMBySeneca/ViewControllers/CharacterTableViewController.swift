//
//  CharacterTableViewController.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    private var rickAndMorty: RickAndMorty?
    
    // MARK: - UISearchController
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCharacter: [Characters] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: APIManager.shared.apiUrl)
        tableView.backgroundColor = .black
        setupSearchController()
        setupNavigationBar()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCharacter.count : rickAndMorty?.results?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharacterTableViewCell
        let characters = isFiltering ? filteredCharacter[indexPath.row] : rickAndMorty?.results?[indexPath.row]
        cell.configure(with: characters)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterDetailVC = segue.destination as? CharacterDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = isFiltering ? filteredCharacter[indexPath.row] : rickAndMorty?.results?[indexPath.row]
        characterDetailVC.character = character
    }
    
    
    @IBAction func leafThroughAction(_ sender: UIBarButtonItem) {
        sender.tag == 0
        ? fetchData(from: rickAndMorty?.info?.prev)
        : fetchData(from: rickAndMorty?.info?.next)
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { [weak self] results in
            switch results {
            case .success(let rickAndMorty):
                self?.rickAndMorty = rickAndMorty
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Setup Navigation bar
    
    private func setupNavigationBar() {
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let navigationBar = UINavigationBarAppearance()
            navigationBar.configureWithOpaqueBackground()
            navigationBar.backgroundColor = .black
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navigationBar
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBar
            navigationController?.navigationBar.tintColor = .white
        }
    }
    
    // MARK: - UISearchController method
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
}

extension CharacterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacter = rickAndMorty?.results?.filter { character in
            character.name!.lowercased().contains(searchText.lowercased())
        } ?? []

        tableView.reloadData()
    }
}
