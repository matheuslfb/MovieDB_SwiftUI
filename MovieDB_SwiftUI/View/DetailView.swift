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
        
        Group{
            HStack(alignment: .top) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 128, height: 194)
                    .cornerRadius(10)
                
                VStack(alignment: .leading){
                    
                    Text(title)
                        .font(.title)
                        .padding(CGFloat(5.0))
                        .lineLimit(1)
                    
                    
                    Text("Acao, Comedia, Terror")
                        .padding(.top, 5.0)
                    
                    
                    HStack {
                        Image(systemName: "star")
                        Text(vote_average)
                            .frame(width: 40)
                            .multilineTextAlignment(.leading)
                    }
                        .padding(CGFloat(5))
                }
            }
                .background(Color.yellow)
            
            .padding(.all)
            
            VStack {
                Text(overview)
                    .multilineTextAlignment(.leading)
                    .background(Color(.cyan))
            }
            .padding(.vertical)
            Rectangle().foregroundColor(.clear)
        }
            
        .navigationBarTitle(Text("Movie Details"), displayMode: .inline)
        .onAppear{
            NetworkService.sharedInstance.fetchImageFromUrl(poster_path: self.poster_path) { imageResult in
                DispatchQueue.main.async {
                    self.image = imageResult
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
