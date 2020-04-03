//
//  SearchBar.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 3/31/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    

    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
     
         func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
               searchBar.resignFirstResponder()
               searchBar.endEditing(true)
           }
        
        
        
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
   
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = .none
        searchBar.showsCancelButton = true

        return searchBar
    }
    
//    func makeUIView(context: UIViewRepresentableContext<UISearchController>) -> UISearchController {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.delegate = context.coordinator as! UISearchControllerDelegate
//        searchController.searchBar.searchBarStyle = .minimal
//        searchController.searchBar.placeholder = placeholder
//        searchController.searchBar.autocapitalizationType = .none
//        searchController.searchBar.showsCancelButton = true
//
//        return searchController
//    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
