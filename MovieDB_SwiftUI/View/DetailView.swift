//
//  DetailView.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 3/31/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    let title: String
    var overview: String = ""
    var vote_average: String = ""
    var poster_path: String = ""
    
    @State var image: UIImage = UIImage()
    var body: some View {
        
        HStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: 84, height: 118)
                .cornerRadius(10)
            
            VStack(alignment: .leading){
                
                Text(title)
                    .font(.title)
                    .padding(CGFloat(5.0))
                    .lineLimit(1)
                    
                   
                Text(overview)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .frame(width: 250.0)
                
                
                HStack {
                    Image(systemName: "star")
                    Text(vote_average)
                        .frame(width: 40)
                        .multilineTextAlignment(.leading)
                }
                .padding(CGFloat(5))
            }
        } .navigationBarTitle(Text("Movie Details"), displayMode: .inline)
            .onAppear{
                NetworkService.sharedInstance.fetchImageFromUrl(poster_path: self.poster_path) { imageResult in
                    DispatchQueue.main.async {
                        self.image = imageResult
                    }
                }
        }
    }
}
