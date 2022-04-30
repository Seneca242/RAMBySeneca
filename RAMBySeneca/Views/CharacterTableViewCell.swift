//
//  CharacterTableViewCell.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    
    func configure(with character: Characters?) {
        nameLabel.text = character?.name
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: character?.image ?? "") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.characterImageView.image = UIImage(data: imageData)
            }
        }
    }
}
