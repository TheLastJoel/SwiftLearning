//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Joel Bearn on 05/10/2022.
//

import SwiftUI

struct HomeView: View {
    
    // Always try to make as private as possible
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack{
            // Background Layer
            Color.theme.background
                .ignoresSafeArea()
            
            // Content Layer
            VStack{
                homeHeader
                Spacer(minLength: 0)
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            // Hidden the navigation bar in preview too
            HomeView()
                .navigationBarHidden(true)
        }
    }
}

//Extension keeps this neat as homeHeader is private and cannot be accessed from other views
extension HomeView{
    
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
