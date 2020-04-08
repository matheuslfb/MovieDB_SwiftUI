//
//  Movie.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 3/31/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI

struct Movie: Codable, Hashable, Identifiable  {
    
    
    var id: Int
    var title: String
    var overview: String
    var vote_average: Double
    var poster_path: String

}

struct Row: Identifiable {
    let id = UUID()
    let cells: [Movie]
}
