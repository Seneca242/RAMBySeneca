//
//  NetworkManager.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

import Foundation

//class NetworkManager {
//    static let shared = NetworkManager()
//    private init() {}
//
//    private func fetchData(from url: String?, completion: @escaping(Result<Data, Error>) -> Void) {
//        guard let url = URL(string: url ?? "") else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, let response = response else {
//                completion(.failure(error?.localizedDescription as! Error))
//                return
//            }
//            print(response)
//
//            do {
//                let data = try JSONDecoder().decode(Data.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(data))
//                }
//            } catch let error {
//                completion(.failure(error.localizedDescription as! Error))
//            }
//        }
//    }
//}

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
        }
    }
}
