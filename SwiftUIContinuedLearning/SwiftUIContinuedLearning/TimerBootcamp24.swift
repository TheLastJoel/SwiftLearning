//
//  TimerBootcamp24.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 07/10/2022.
//

import SwiftUI

struct TimerBootcamp24: View {
    
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    // Current Time
    /*
    
    @State var currentDate: Date = Date()
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
     */
    
    //Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureData: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining(){
        let remaining = Calendar.current.dateComponents([.hour,.minute, .second], from: Date(), to: futureData)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
     */
    
    //Animation Counter
    @State var count: Int = 1
    
    var body: some View {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color(UIColor.systemOrange), Color(UIColor.systemPink)]),
                    center: .center,
                    startRadius: 5,
                    endRadius: 500)
                .ignoresSafeArea()
                
                //TabView
                TabView(selection: $count) {
                    Rectangle()
                        .foregroundColor(.red)
                        .tag(1)
                    Rectangle()
                        .foregroundColor(.orange)
                        .tag(2)
                    Rectangle()
                        .foregroundColor(.yellow)
                        .tag(3)
                    Rectangle()
                        .foregroundColor(.pink)
                        .tag(4)
                    Rectangle()
                        .foregroundColor(.green)
                        .tag(5)

                }
                .frame(height: 300, alignment: .center)
                .tabViewStyle(.page)
                
                //Animation HStack
                /*
                HStack(spacing: 15){
                    Circle()
                        .offset(y: count == 1 ? -20 : 0)
                    Circle()
                        .offset(y: count == 2 ? -20 : 0)
                    Circle()
                        .offset(y: count == 3 ? -20 : 0)
                }
                .foregroundColor(.white)
                .frame(width: 200)
                 */
                
                // Text
                /*
                Text(timeRemaining)
                    .font(.system(size: 100, weight: .semibold, design: .serif))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .padding()
                 */
            }
            .onReceive(timer, perform: { _ in
                withAnimation(.default){
                    count = count == 5 ? 1 : count + 1
                }
//                updateTimeRemaining()
        })

    }
}

struct TimerBootcamp24_Previews: PreviewProvider {
    static var previews: some View {
        // Need some form of stack for the timer to publish on preview for some reason
        ZStack{
            TimerBootcamp24()
        }
    }
}
