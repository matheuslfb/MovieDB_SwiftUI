//
//  NowPlayingCell.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 4/6/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI

struct NowPlayingCell: View {
    @State var image: UIImage = UIImage()
    @State var isFavorite =  false
    
    var cellContent:  Movie
    
    var body: some View {
        VStack(alignment: .leading){
            Image(uiImage: image).renderingMode(.original)
                .resizable()
                .frame(width: 128, height: 194)
                .cornerRadius(10)
            
            
            Text(cellContent.title)
                .multilineTextAlignment(.leading)
                .frame(width: 128)
                .lineLimit(1)
                .foregroundColor(Color.primary)
            
            HStack(spacing: 5) {
                Image(systemName: isFavorite ? "star.fill" : "star").renderingMode(.original)
                    .frame(width: 16, height: 16)
                Text(cellContent.vote_average.cleanValue)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
            }
            
        }.padding(.leading, 8)
            .onAppear {
                
                NetworkService.sharedInstance.fetchImageFromUrl(poster_path: self.cellContent.poster_path) { imageResult in
                    DispatchQueue.main.async {
                        self.image = imageResult
                    }
                }
        }
    }
}
