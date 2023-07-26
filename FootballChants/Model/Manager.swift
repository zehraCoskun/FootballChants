//
//  Manager.swift
//  FootballChants
//
//  Created by Zehra Coşkun on 18.07.2023.
//

import Foundation

enum JobType : String {
    case manager = "Manager"
    case headCoach = "Head Coach"
}
struct Manager {
    let name: String
    let job: JobType
}
