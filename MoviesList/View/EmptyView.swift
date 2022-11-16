//
//  EmptyView.swift
//  MoviesList
//
//  Created by ozlem on 3.11.2022.
//

import SwiftUI

struct EmptyView: View {
    var error:String
       var body: some View {
           ProgressView(error).padding(.top)
       }
   }

   struct EmptyView_Previews: PreviewProvider {
       static var previews: some View {
           EmptyView(error: "Error!")
       }
   }
