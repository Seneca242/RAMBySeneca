//
//  EpisodeDetailViewController.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet var titleAndDateLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var episode: Episode?
    var characters: [Characters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters(url: episode?.characters ?? [])
        titleAndDateLabel.text = episode?.description
        tableView.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )
        title = episode?.episode
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchCharacters(url: [String]) {
        url.forEach { url in
            NetworkManager.shared.fetchCharacter(from: url) { [weak self] results in
                switch results {
                case .success(let character):
                    self?.characters.append(character)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EpisodeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        characters.count
        episode?.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterUrl", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
//        let characters = characters[indexPath.row]
//        cell.configure(with: characters)
        let characterUrl = episode?.characters?[indexPath.row]
        NetworkManager.shared.fetchCharacter(from: characterUrl) { results in
            switch results {
            case .success(let character):
                cell.configure(with: character)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return cell
    }
}

extension EpisodeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
