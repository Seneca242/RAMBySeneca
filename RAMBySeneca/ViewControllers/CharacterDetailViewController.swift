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
    
    var character: Characters?
    private var activityIndicatorView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = character?.name
        characterDescriptionLabel.text = character?.characterDescription
        fetchImage(from: character?.image)
        activityIndicatorView = showActivityIndicator(in: view)
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let episodesTableVC = navigationController.topViewController as? EpisodesTableViewController else { return }
        episodesTableVC.character = character
    }
    
    private func fetchImage(from url: String?) {
        ImageNetworkManager.shared.fetchImage(from: url ?? "") { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.activityIndicatorView?.stopAnimating()
                self?.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                self?.imageView.image = UIImage(systemName: "camera.macro")
                print(error)
            }
        }
    
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}
