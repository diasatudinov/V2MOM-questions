//
//  VQProject.swift
//  V2MOM questions
//
//

import SwiftUI

struct Project: Codable, Hashable, Identifiable {
    var id = UUID()
    var vision: String
    var values: [Value]
    var methods: [Method]
    var obstacles: Obstacles
    var measures: String
    var queastionOneAnswer: Answer
    var queastionTwoAnswer: Answer
    var title: String
    var type: ProjectType
    var status: ProjectStatus
    var date: Date = .now
}

struct Value: Codable, Hashable {
    var id = UUID()
    var text: String
}

struct Method: Codable, Hashable, Identifiable {
    var id = UUID()
    var text: String
}

struct Obstacles: Codable, Hashable {
    var id = UUID()
    var text: String
    var tags: [ObstacleTag]
}

enum ObstacleTag: Codable, CaseIterable {
    case lackOfTime
    case budget
    case team
    
    var text: String {
        switch self {
        case .lackOfTime:
            "Lack of time"
        case .budget:
            "Budget"
        case .team:
            "Team"
        }
    }
}

enum Answer: Codable, CaseIterable {
    case vision
    case values
    case methods
    case obstacles
    case measures
    
    var text: String {
        switch self {
        case .vision:
            "Vision"
        case .values:
            "Values"
        case .methods:
            "Methods"
        case .obstacles:
            "Obstacles"
        case .measures:
            "Measures"
        }
    }
}
enum ProjectType: String, Codable, CaseIterable, Identifiable {
    case business
    case personal
    case team
    
    var id: String { rawValue }
    
    var text: String {
        switch self {
        case .business:
            "Business"
        case .personal:
            "Personal"
        case .team:
            "Team"
        }
    }
}

enum ProjectStatus: String, Codable, CaseIterable, Identifiable {
    case atWork
    case ready
    case cancelled
    
    var id: String { rawValue }
    
    var text: String {
        switch self {
        case .atWork:
            "At work"
        case .ready:
            "Ready"
        case .cancelled:
            "Cancelled"
        }
    }
}
