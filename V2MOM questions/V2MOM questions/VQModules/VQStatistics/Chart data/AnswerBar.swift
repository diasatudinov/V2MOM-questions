import SwiftUI
import Charts

struct AnswerBar: Identifiable, Hashable {
    let id = UUID()
    let answer: Answer
    let percent: Double   // 0...100
}

func answerDistribution(
    projects: [Project],
    keyPath: KeyPath<Project, Answer>
) -> [AnswerBar] {
    let total = projects.count
    guard total > 0 else {
        return Answer.allCases.map { AnswerBar(answer: $0, percent: 0) }
    }

    let counts = Dictionary(grouping: projects, by: { $0[keyPath: keyPath] })
        .mapValues(\.count)

    return Answer.allCases.map { a in
        let c = counts[a, default: 0]
        let p = Double(c) / Double(total) * 100.0
        return AnswerBar(answer: a, percent: p)
    }
}

struct StatusSlice: Identifiable, Hashable {
    let id = UUID()
    let status: ProjectStatus
    let value: Double   // count или доля
}

func slices(from projects: [Project]) -> [StatusSlice] {
    let total = projects.count
    let counts = Dictionary(grouping: projects, by: \.status).mapValues(\.count)

    // если total = 0 — покажем нули
    return ProjectStatus.allCases.map { status in
        let c = Double(counts[status, default: 0])
        return StatusSlice(status: status, value: c)
    }
}