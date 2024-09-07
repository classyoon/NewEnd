//
//  ContentView.swift
//  NewEnd
//
//  Created by Conner Yoon on 9/7/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm : EndVM
    var body: some View {
        VStack {
            Text(vm.endingText)
            Button(vm.endingButton){
                vm.setEnd()
            }
            
        }
    }

    
}

#Preview {
    ContentView(vm: EndVM())
}
enum EndingType {
    case first, second, third
}
class EndDecider {
    var end : EndingType
    
    func endOne(){
        print("1")
    }
    func endTwo(){
        print("2")
    }
    func endThree(){
        print("3")
    }
    func rotate(){
        switch end {
        case .first :
            end = .second
            print("Rotate 1")
        case .second :
            end = .third
            print("Rotate 2")
        case .third :
            end = .first
            print("Rotate 3")
        }
    }
    
    init(end: EndingType = .first) {
        self.end = end
    }
}
class EndVM : ObservableObject{
    var model : EndDecider = EndDecider()
    @Published var endingText : String = "nothing"
    @Published var endingButton : String = "begin"
    @Published var buttonAction : ()
    
    func setEnd(){
        rotate()
        switch model.end {
        case .first:
            buttonAction = model.endOne()
            endingText = "Ending 1, tap to move to ending 2"
            endingButton = "Ending 2"
        case .second:
            buttonAction = model.endTwo()
            endingText = "Ending 2, tap to move to ending 3"
            endingButton = "Ending 3"
        case .third:
            buttonAction = model.endThree()
            endingText = "Ending 3, tap to move to ending 1"
            endingButton = "Ending 1"
        }
        
    }
    func rotate(){
        model.rotate()
    }
    
}
