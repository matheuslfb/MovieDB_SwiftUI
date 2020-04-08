//
//  SeeAllNowPlayingView.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 4/7/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI

struct SeeAllNowPlayingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var moviesObject: MoviesObject
    //    let title: String
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach (self.moviesObject.nowPlayingMovies, id: \.self) { movie in
//                    NavigationLink(destination: MovieDetailView(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)) {
                    HStack(spacing: 10) {
                            NowPlayingCell(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)
                            NowPlayingCell(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)
                    }.padding()
                        
//                    }
                }
            }
            .navigationBarTitle(Text("Now Playing"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                print("Dismissing sheet view...")
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done").bold()
            })
        }.onAppear {
            dump(self.moviesObject.$nowPlayingMovies)
        }
        
        
    }
}

struct SeeAllNowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllNowPlayingView().environmentObject(MoviesObject())
    }
}
