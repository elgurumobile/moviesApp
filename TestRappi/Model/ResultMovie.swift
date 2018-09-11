//
//  ResultMovie.swift
//  TestRappi
//
//  Created by Felipe Aragon on 9/10/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import Foundation

struct ResultMovie: Codable {
    var page: Int?
    var total_results : Int?
    var total_pages: Int?
    var results: [Movie]?
    
}
