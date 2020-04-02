//
//  Movie.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 3/31/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable  {
    
//    var _id = UUID()
    
    var id: Int
    var title: String
    var overview: String
//    var genres: String
    var vote_average: Double
    var poster_path: String
//    var poster: NSData
    
}
