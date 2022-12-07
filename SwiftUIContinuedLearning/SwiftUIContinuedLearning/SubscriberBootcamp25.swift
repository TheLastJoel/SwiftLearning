//
//  SubscriberBootcamp25.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 19/10/2022.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject{
    
    @Published var count: Int = 0
    
//    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init(){
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber(){
        $textFieldText
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                }
                
                return false
            }
        //use sink as can use weak self
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber(){
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                
                guard let self = self else {return}
                if isValid && count > 10{
                    self.showButton = true
                }
                else{
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func setUpTimer(){
//        timer =
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else{return}
                self.count += 1
                
                if self.count >= 10 {
//                    for item in self.cancellables{
//                        item.cancel()
//                    }
                    //Stops publishing times
//                    self.timer?.cancel()
                }
            }
            .store(in: &cancellables)
        
        // sink is where the value that is being published is sent
    }
    
}

struct SubscriberBootcamp25: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack{
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
                .padding()
                .background(Color(vm.textIsValid ? .green : .red))
                .cornerRadius(10)
            
            TextField("type something here...", text: $vm.textFieldText)
                .padding()
                .frame(height: 55)
                .background(Color(.lightGray))
                .cornerRadius(10)
                .overlay(alignment: .trailing){
                    ZStack(alignment: .trailing){
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                // Chaining multiple ternary operations i.e AND
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0
                            )
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.headline)
                    .padding(.trailing)
                    
                    
                }
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)

            
        }
        .padding()
    }
}

struct SubscriberBootcamp25_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp25()
    }
}
