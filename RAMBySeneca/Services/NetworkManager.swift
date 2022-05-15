//
//  NetworkManager.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case someError(message: String)
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchData(from url: String?, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.someError(message: error?.localizedDescription ?? "No error description")))
                return
            }
            print(response)

            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(rickAndMorty))
                }
            } catch let error {
                completion(.failure(.someError(message: error.localizedDescription)))
            }
        }.resume()
    }
    
    func fetchCharacter(from url: String?, completion: @escaping(Result<Characters, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.someError(message: error?.localizedDescription ?? "No error description")))
                return
            }
            print(response)
            do {
                let character = try JSONDecoder().decode(Characters.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(character))
                }
                
            } catch let error {
                completion(.failure(.someError(message: error.localizedDescription)))
            }
        }.resume()
    }
    
    func fetchEpisode(from url: String?, with completion: @escaping(Result<Episode, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.someError(message: error?.localizedDescription ?? "")))
                return
            }
            print(response)
            do {
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(episode))
                }
            } catch let error {
                completion(.failure(.someError(message: error.localizedDescription)))
            }
        }.resume()
    }
}

class ImageNetworkManager {
    static let shared = ImageNetworkManager()
    private init() {}
    
    func fetchImage(from url: String, with completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.someError(message: error?.localizedDescription ?? "No error description")))
                return
            }
            print(response)
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
    
//    Option 1 (see CharacterTableViewCell)
//    func fetchImage(from url: String?) -> Data? {
//        guard let imageUrl = URL(string: url ?? "") else { return nil }
//        guard let imageData = try? Data(contentsOf: imageUrl) else { return nil}
//        return imageData
//    }
    
    
}
