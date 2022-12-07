//
//  StatisticsModel.swift
//  SwiftfulCrypto
//
//  Created by Joel Bearn on 10/10/2022.
//

import Foundation

// DISCUSSION: It is interesting that a struct which is not a view is being used to help pre-fab views

struct Statistic: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
     
}


