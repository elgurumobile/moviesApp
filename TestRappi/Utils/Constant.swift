//
//  Constant.swift
//  TestIntergrupo
//
//  Created by Felipe Aragon on 8/30/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import Foundation

struct Constants {
    
    struct API {
        private static let key = "af6ddf913d21e47731995cf06db48af3"
        private static let urlBase = "https://api.themoviedb.org/"
        static let urlPopularMovies = urlBase+"4/discover/movie?api_key="+key+"&sort_by=popularity.desc&page="
        static let urlTopRatedMovies = urlBase+"4/discover/movie?api_key="+key+"&sort_by=vote_average.desc&page="
        static let urlUpcomingMovies = urlBase+"3/movie/upcoming?api_key="+key+"&page="
        
        static let imageUrlBase = "https://image.tmdb.org/t/p/w200"
        static let imageUrlBaseLarge = "https://image.tmdb.org/t/p/w500"
    }
    
}
