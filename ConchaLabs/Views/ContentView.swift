//
//  ContentView.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/22/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewmodel: Viewmodel
    
    init() {
        self._viewmodel = StateObject(wrappedValue: Viewmodel())
    }
    
    @State private var maxHeight: CGFloat = UIScreen.main.bounds.height / 2.5
    @State private var sliderProgress: CGFloat = 0
    @State private var sliderHeight: CGFloat = 0
    @State private var lastDragValue: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            
            Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1))
                .ignoresSafeArea()
            
            if viewmodel.isComplete == "" {
                VStack {
                    Spacer()
                    TitleView()
                        .padding()
                    SliderView()
                    Spacer()
                    BottomButtonView()
                        .padding(.bottom, 50)
                    Spacer()
                }
                SideButtonView()
                    .offset(x: 100)
            } else {
                SliderResultsView()
            }
        }
        .preferredColorScheme(.dark)
        .environmentObject(viewmodel)
        .task {
            await viewmodel.getStart()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Viewmodel())
    }
}
