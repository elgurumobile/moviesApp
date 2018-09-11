//
//  Movie.swift
//  TestRappi
//
//  Created by Felipe Aragon on 9/10/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int?
    var popularity : Float?
    var video: Bool?
    var vote_count: Int?
    var vote_average: Float?
    var title: String?
    var overview: String?
    var backdrop_path: String?
    var poster_path: String?    
}
