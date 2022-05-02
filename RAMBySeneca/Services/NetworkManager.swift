//
//  NetworkManager.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchData(from url: String?, completion: @escaping(Result<RickAndMorty, Error>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            print(response)

            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(rickAndMorty))
                }
            } catch let error {
                completion(.failure(error.localizedDescription as! Error))
            }
        }.resume()
    }
    
    func fetchCharacter(from url: String?, completion: @escaping(Result<Characters, Error>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            print(response)
            do {
                let character = try JSONDecoder().decode(Characters.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(character))
                }
                
            } catch let error {
                completion(.failure(error.localizedDescription as! Error))
            }
        }.resume()
    }
}

class ImageNetworkManager {
    static let shared = ImageNetworkManager()
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let imageUrl = URL(string: url ?? "") else { return nil }
        guard let imageData = try? Data(contentsOf: imageUrl) else { return nil}
        return imageData
    }
}
