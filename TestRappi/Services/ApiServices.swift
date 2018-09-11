//
//  ApiSpotify.swift
//  SpotifyApp
//
//  Created by Felipe Aragon on 7/24/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

enum TypeRequest:Int{
    case popular = 0
    case toprated
    case upcoming
}

class ApiServices {
    
    static var shared = ApiServices()
    
    /// Parse JSON data
    func parseObject(data: Data) throws -> ResultMovie {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultMovie.self, from:data)
            return result
            
        } catch {
            throw moviesError("Error: \(error)")
        }
    }
    
    
    /// Make API request
    func getMovies(typeRequest: TypeRequest , page : Int = 1) -> Observable<ResultMovie>{
        
        let urlString = "\(getUrlrequest(typeRequest: typeRequest))\(page)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        return session.rx.data(request: request).map({ data  in
            return try self.parseObject(data: data)
        })
        
    }
    
    private func getUrlrequest(typeRequest: TypeRequest) -> String{
        switch typeRequest {
        case .popular:
            return Constants.API.urlPopularMovies
        case .toprated:
            return Constants.API.urlTopRatedMovies
        case .upcoming:
            return Constants.API.urlUpcomingMovies
        }
    }
    
    func moviesError(_ error: String, location: String = "\(#file):\(#line)") -> NSError {
        return NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "\(location): \(error)"])
    }
    
}
