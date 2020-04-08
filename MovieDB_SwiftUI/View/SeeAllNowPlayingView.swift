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
    
    private struct DoubleMovie{
        let uuid = UUID()
        var first: Movie
        var second: Movie
    }
    
    private var data: [DoubleMovie] {
        let maxIndex = moviesObject.nowPlayingMovies.count % 2 == 0 ? moviesObject.nowPlayingMovies.count : moviesObject.nowPlayingMovies.count - 1
        var i = 0
        var result: [DoubleMovie] = []
        while i < maxIndex {
            result.append(DoubleMovie(first: moviesObject.nowPlayingMovies[i], second: moviesObject.nowPlayingMovies[i+1]))
            i += 2
        }
        return result
    }
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach (data, id: \.uuid) { movie in
//                    NavigationLink(destination: MovieDetailView(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)) {
                    HStack(spacing: 10) {
                        NowPlayingCell(cellContent: movie.first)
                        NowPlayingCell(cellContent: movie.second)
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
