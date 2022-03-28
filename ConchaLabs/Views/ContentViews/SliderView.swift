//
//  SliderView.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/25/22.
//

import SwiftUI

struct SliderView: View {
    
    @EnvironmentObject private var viewmodel: Viewmodel
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Capsule()
                .fill(.gray)
                .frame(width: 30, height: viewmodel.maxHeight)
            
            Capsule()
                .fill(LinearGradient(colors: [.indigo, .yellow], startPoint: .top, endPoint: .bottom)).opacity(0.7)
                .frame(width: 30, height: viewmodel.snapOffset)
            
            
            VStack {
                ForEach(0..<viewmodel.sliderLineCount, id: \.self) { index in
                    Rectangle()
                        .fill( viewmodel.sliderHeight < CGFloat(index * (Int(CGFloat(viewmodel.maxHeight)) / 14)) ? .black : .white)
                        .frame(width: 30, height: 1.5)
                        .padding(7)
                }
            }
            .frame(height: viewmodel.maxHeight, alignment: .center)
        }
        .overlay(
            ZStack(alignment: .center) {
                Circle()
                    .fill(.yellow)
                    .opacity(0.5)
                    .frame(width: 50, height: 50)
                    .offset(y: viewmodel.snapOffset - ((viewmodel.maxHeight) / 2))
                
                Circle()
                    .fill(.white)
                    .frame(width: 30, height: 30)
                    .offset(y: viewmodel.snapOffset - ((viewmodel.maxHeight) / 2))
            }
        )
        .frame(width: 30, height: viewmodel.maxHeight, alignment: .center)
        .rotationEffect(Angle(degrees: 180))
        
        .gesture(DragGesture(minimumDistance: 0).onChanged({ (value) in
            viewmodel.drag(value)
        })
            .onEnded({ (value) in
                viewmodel.onEnded(value)
            }))
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
            .environmentObject(Viewmodel())
        
        
        
        
    }
}

