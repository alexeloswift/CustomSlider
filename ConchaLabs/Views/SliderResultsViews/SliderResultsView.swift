//
//  SliderResultsView.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/28/22.
//

import SwiftUI

struct SliderResultsView: View {
    
    @EnvironmentObject private var viewmodel: Viewmodel
    
    var body: some View {
        
        ZStack {
            
            Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Slider Results")
                    .font(.custom("Georgia", size: 24, relativeTo: .headline))
                    .padding(.bottom, 5)
                
                HStack {
                    VStack {
                        ForEach(1..<4) { num in
                            Text("Slider \(num):")
                                .italic()
                        }
                    }
                    
                    VStack {
                        ForEach(viewmodel.keys, id: \.self) { key in
                            Text("\(key)")
                        }
                        .padding(.leading, 30)
                    }
                    
                    VStack {
                        ForEach(viewmodel.values, id: \.self) { value in
                            Text("\(value, specifier: "%.2f")")
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.bottom, 40)
                
                StartOverButton()
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct SliderResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SliderResultsView()
            .environmentObject(Viewmodel())
    }
}
