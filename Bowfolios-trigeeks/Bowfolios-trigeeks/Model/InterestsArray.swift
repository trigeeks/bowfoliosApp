//
//  InterestsArray.swift
//  Bowfolios-trigeeks
//
//  Created by Yuhan Jiang on 2020/9/13.
//  Copyright © 2020 trigeeks. All rights reserved.
//

//  This is the hard-coded interests array that can be called in other files

import Foundation

class InterestsArray: ObservableObject {
    
    @Published var interestsArray: [String] = ["Software Engineering", "Climate Change", "HPC", "Distributed Computing", "Renewable Energy", "AI", "Visualization", "Scalable IP Networks", "Educational Technology", "Unity", "iOS Development"].sorted()
    
}
