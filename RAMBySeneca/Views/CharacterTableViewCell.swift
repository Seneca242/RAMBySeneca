//
//  CharacterTableViewCell.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }
    

    
    func configure(with character: Characters?) {
        nameLabel.text = character?.name
        
        ImageNetworkManager.shared.fetchImage(from: character?.image ?? "") { result in
            switch result {
            case .success(let imageData):
                self.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
//        see option 1 in NetworkManager
//        DispatchQueue.global().async {
//            guard let imageData = ImageNetworkManager.shared.fetchImage(from: character?.image) else { return }
//            DispatchQueue.main.async { [weak self] in
//                self?.characterImageView.image = UIImage(data: imageData)
//            }
//        }
    }
}
