//
//  TF.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 4/13/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI
import Introspect

struct TF: View {
    
    @State var texto: String = ""
    var body: some View {
        
        VStack {
            
            TextField("Ola", text: $texto).introspectTextField { (tf) in
                tf.borderStyle = .none
            }.frame(width: 120, height: 50)
        }.background(Color.blue)
        
            
        
    }
}

struct TF_Previews: PreviewProvider {
    static var previews: some View {
        TF()
    }
}
