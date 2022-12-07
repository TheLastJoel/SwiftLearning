//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Joel Bearn on 10/10/2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                        .theme.secondaryText : .theme.accent)
            
            TextField("Search by name or symbol ...", text: $searchText )
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(.theme.accent)
                        .opacity(
                            searchText.isEmpty ?
                            0 : 1
                        )
                        .onTapGesture {
                            UIApplication.shared.endEditting()
                            searchText = ""
                        }
                    
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.5),
                    radius: 10)
            )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SearchBarView(searchText: .constant(""))
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            SearchBarView(searchText: .constant(""))
                .padding()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }

    }
}
