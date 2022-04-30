//
//  API.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 30.04.2022.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    let apiUrl = "https://rickandmortyapi.com/api/character"
}
