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
  var body: some View {
    Text(title)
    .navigationBarTitle(Text(title), displayMode: .inline)
  }
}
