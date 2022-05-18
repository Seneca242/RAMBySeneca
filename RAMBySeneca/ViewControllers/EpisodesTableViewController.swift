//
//  EpisodesTableViewController.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import UIKit

class EpisodesTableViewController: UITableViewController {

    var character: Characters?
    var episode: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 0.7
        )
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.backgroundColor = .white
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character?.episode?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let url = character?.episode?[indexPath.row]
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        NetworkManager.shared.fetchEpisode(from: url) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let episode):
//                self?.episode = episode
                self?.episode.append(episode)
                content.text = episode.name
                cell.contentConfiguration = content
            }
        }
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episode[indexPath.row]
        performSegue(withIdentifier: "showEpisode", sender: episode)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeDetailVC = segue.destination as? EpisodeDetailViewController else { return }
        episodeDetailVC.episode = sender as? Episode
    }

}
