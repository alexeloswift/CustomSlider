//
//  Viewmodel.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/22/22.
//

import Foundation
import SwiftUI


@MainActor
class Viewmodel: NSObject, ObservableObject {
    
    private let network = Network()
    private let apiService = APIService()
    
    @Published var maxHeight: CGFloat = UIScreen.main.bounds.height / 2.5
    @Published var sliderHeight: CGFloat = 0
    @Published var lastDragValue: CGFloat = 0
    
    @Published var tick: Double = 0.0
    @Published var ticks = [Double]()
    @Published var sliderIndex = 0
    @Published var index = 0
    @Published var sliderResponses = [Int : Double]()
    @Published var sliderLineCount = 14
    @Published var isComplete: String = ""
    @Published var error: Error?
    @Published var sessionID: Int?
    
///    Slider Results Key & Values
    
    var keys: [Int] {
        return sliderResponses.keys.sorted().map { Int($0) }
    }
    
    var values: [Double] {
        return sliderResponses.values.sorted().map { Double($0) }
    }
    
    func updateResults() {
        sliderResponses[index] = tick
    }
    
    
///    Setting Ticks and Index
    
    var selectedTick: Double {
        
        index = Int(sliderHeight * 14 / maxHeight)
        tick = ticks[Int((sliderHeight * 15) / maxHeight)]
        
        return ticks[Int((sliderHeight * 15) / maxHeight)]
    }
    

///    SnapOffset with stepUp & stepDown
    
    var snapOffset: CGFloat {
        get {
            CGFloat(Int(sliderHeight * 14 / maxHeight)) * (maxHeight / 14)
        }
        set {
            sliderHeight = newValue * (14 / maxHeight) * (maxHeight / 14)
        }
    }
    
    func stepUp() {
        snapOffset += (maxHeight / 14)
        snapOffset = sliderHeight >= maxHeight ? maxHeight : sliderHeight
        
        print("sliderheight: \(sliderHeight)")
        print("Index: \(Int(sliderHeight * 14 / maxHeight))")
        print("Tick: \(selectedTick)")
        print("SnapOffset: \(snapOffset)")
    }
    
    func stepDown() {
        snapOffset -= (maxHeight / 14)
        snapOffset = sliderHeight <= 0 ? 0 : sliderHeight
        
        print("sliderheight: \(sliderHeight)")
        print("Index: \(Int(sliderHeight * 14 / maxHeight))")
        print("Tick: \(selectedTick)")
        print("SnapOffset: \(snapOffset)")
    }
    
///    Setting Drag & Ended Values
    
    func drag(_ value: DragGesture.Value) {
        let translation = value.translation
        sliderHeight = -translation.height + lastDragValue
        
        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
        sliderHeight = sliderHeight >= 1 ? sliderHeight : 1
        
        print("sliderheight: \(sliderHeight)")
        print("Index: \(Int(sliderHeight * 14 / maxHeight))")
        print("Tick: \(selectedTick)")
        print("SnapOffset: \(snapOffset)")
    }
    
    func onEnded(_ value: DragGesture.Value) {
        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
        sliderHeight = sliderHeight >= 1 ? sliderHeight : 1
        lastDragValue = sliderHeight
    }
    

///    Resetting for Start Over Button
    
    func reset() {
        self.isComplete = ""
        self.tick = 0.0
        self.sliderResponses = [Int : Double]()
        self.sessionID = 0
        self.sliderIndex = 0
        self.ticks = [Double]()
        self.sliderHeight = 0
    }
    
///    Getting & Sending Values to API
    
    func getStart() async {
        do {
            let response: SliderResults = try await network.makeRequest(for: apiService.request(for: .testStart))
            self.sessionID = response.sessionID
            self.ticks = response.ticks
            self.sliderIndex = response.stepCount
            
            print(ticks)
            print(sessionID ?? 0)
            print(sliderIndex)
            
        } catch {
            self.error = error
        }
    }
    
    func getNext() async {
        do {
            let response: SliderResults = try await network.makeRequest(for: apiService.request(for: .testNext(sessionID: sessionID ?? 0, choice: sliderIndex)))
            self.sessionID = response.sessionID
            self.sliderIndex = response.stepCount
            self.isComplete = response.isCompleted
            
            print(sessionID ?? 0)
            print(sliderIndex)
            
        } catch {
            self.error = error
        }
    }
}
