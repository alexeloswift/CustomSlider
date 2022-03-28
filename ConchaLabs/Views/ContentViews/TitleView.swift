//
//  TitleView.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/25/22.
//

import SwiftUI

struct TitleView: View {
    
    @EnvironmentObject private var viewmodel: Viewmodel
    
    var body: some View {

        VStack(alignment: .center, spacing: 30) {
            Text("Please Take This Test")
                .font(.custom("Georgia", size: 24, relativeTo: .headline))

            viewmodel.error.map({Text($0.localizedDescription)})
            
            Text("Current Value: \(viewmodel.tick , specifier: "%.2f")")
        }
    }
}
    

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
            .environmentObject(Viewmodel())
        
    }
}
