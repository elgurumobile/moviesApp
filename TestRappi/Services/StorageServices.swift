//
//  Storage.swift
//  TestIntergrupo
//
//  Created by Felipe Aragon on 8/30/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import Foundation

class StorageServices {
    
    static var shared = StorageServices()
    
    func saveMovies(resultMovie:[Movie],typeRequest: TypeRequest)  {
        if let encoded = try? JSONEncoder().encode(resultMovie) {
            UserDefaults.standard.set(encoded, forKey: "ResultMovie\(typeRequest)")
        }
    }
    
    func loadMovies(typeRequest: TypeRequest) -> [Movie]?{
        if let resultMovieData = UserDefaults.standard.data(forKey: "ResultMovie\(typeRequest)"),
            let resultMovie = try? JSONDecoder().decode([Movie].self, from: resultMovieData) {
            return resultMovie
        }
        return nil
    }
    
}
