//
//  CharacterDetailViewController.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.width / 2
        }
    }
    
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    var characterUrl: String?
//    var character: RickAndMorty?
    var character: Characters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacterDescription(from: characterUrl)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    private func fetchCharacterDescription(from url: String?) {
//        NetworkManager.shared.fetchData(from: url) { characters in
//            switch characters {
//            case .success(let character):
//                self.character = character
//                self.characterDescriptionLabel.text = character.results?.description
//            case .failure(let error):
//                print(error)
//            }
//        }
        NetworkManager.shared.fetchCharacter(from: url) { characters in
            switch characters {
            case .success(let character):
                self.character = character
                self.characterDescriptionLabel.text = character.characterDescription
                self.fetchImage(from: character.image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage(from url: String?) {
        guard let imageData = ImageNetworkManager.shared.fetchImage(from: url) else { return }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: imageData)
        }
    }
}
