//
//  StartOverButton.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/28/22.
//

import SwiftUI

/// Given more time for this project I would have loved to implement a more advanced approach for the buttons. As you can see I gave the button a task to handle updating the UI from the main thread. I'll leave the link to an article I really liked explaining what I'm talking about https://www.swiftbysundell.com/articles/building-an-async-swiftui-button/

struct StartOverButton: View {
    
    @EnvironmentObject private var viewmodel: Viewmodel
    
    var body: some View {
        
        Button(action: {
            viewmodel.reset()
            Task {
                await viewmodel.getStart()
            }}) {
                Text("Start Over")
                    .frame(width: UIScreen.main.bounds.width * 0.75,
                           height: UIScreen.main.bounds.width * 0.075)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(.yellow)
            .foregroundColor(.black)
    }
}



struct StartOverButton_Previews: PreviewProvider {
    static var previews: some View {
        StartOverButton()
    }
}
