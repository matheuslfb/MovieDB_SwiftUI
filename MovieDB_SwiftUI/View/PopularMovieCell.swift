//
//  MovieCell.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 4/2/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI

struct PopularMovieCell: View {
    var cellContent:  Movie
    @State var image: UIImage = UIImage()
    
    var body: some View {
        
        HStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: 84, height: 118)
                .cornerRadius(10)
            
            VStack(alignment: .leading){
                
                Text(cellContent.title)
                    .font(.title)
                    .padding(CGFloat(5.0))
                    .lineLimit(1)
                
                Text(cellContent.overview)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .frame(width: 250.0)
                
                
                HStack {
                    Image(systemName: "star")
                    Text(cellContent.vote_average.cleanValue)
                        .frame(width: 40)
                        .multilineTextAlignment(.leading)
                }
                .padding(CGFloat(5))
            }
        }.onAppear {
            
            NetworkService.sharedInstance.fetchImageFromUrl(poster_path: self.cellContent.poster_path) { imageResult in
                DispatchQueue.main.async {
                    self.image = imageResult
                }
            }
        }
        
    }
    
    
}


