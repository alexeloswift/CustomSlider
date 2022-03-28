//
//  SideButtonView.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/25/22.
//

import SwiftUI

struct SideButtonView: View {
    
    @EnvironmentObject private var viewmodel: Viewmodel
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            topSideButton
            bottomSideButton
        }
    }
    
    private var topSideButton: some View {
        Button(action: {
            viewmodel.stepUp()
        }) {
            Image(systemName: "chevron.up")
                .frame(width: UIScreen.main.bounds.width * 0.06,
                       height: UIScreen.main.bounds.width * 0.075)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.white)
        .foregroundColor(.yellow)
    }
    
    private var bottomSideButton: some View {
        Button(action: {
            viewmodel.stepDown()
        }) {
            Image(systemName: "chevron.down")
                .frame(width: UIScreen.main.bounds.width * 0.06,
                       height: UIScreen.main.bounds.width * 0.075)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.white)
        .foregroundColor(.yellow)
    }
}

struct SideButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SideButtonView()
            .environmentObject(Viewmodel())
        
        
    }
}
