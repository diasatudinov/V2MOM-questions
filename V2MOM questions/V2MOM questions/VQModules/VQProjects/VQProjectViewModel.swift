//
//  VQProjectViewModel.swift
//  V2MOM questions
//
//

import SwiftUI

final class VQProjectViewModel: ObservableObject {
    @Published var openCreateProjectFlow: Bool = false
    @Published var projects: [Project] = [
//        Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .atWork),
//        Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .atWork),
//        Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .atWork),
//        Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .atWork),
//        Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .atWork),
//        Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .atWork),
//        Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .atWork)
    ] {
        didSet {
            saveProjects()
        }
    }
    
    init() {
        loadProjects()
    }
    
    private let userDefaultsProjectsKey = "projectKey"
    
    // MARK: INCOMES
    
    func saveProjects() {
        if let encodedData = try? JSONEncoder().encode(projects) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsProjectsKey)
        }
        
    }
    
    func loadProjects() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsProjectsKey),
           let loadedItem = try? JSONDecoder().decode([Project].self, from: savedData) {
            projects = loadedItem
        } else {
            print("No saved data found: projects")
        }
    }
    
    
    func add(_ project: Project) {
        projects.append(project)
    }
    
    func editStatus(_ project: Project, newStatus: ProjectStatus) {
        guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
        projects[index].status = newStatus
    }
    
    
    func delete(project: Project) {
        guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
        projects.remove(at: index)
    }
    
    func count(for status: ProjectStatus) -> Int {
        self.projects.filter { $0.status == status }.count
    }

    func percent(for status: ProjectStatus) -> Double {
        let total = self.projects.count
        guard total > 0 else { return 0 }
        return Double(count(for: status)) / Double(total) * 100
    }
    
    private func mostFrequentAnswerResult(
        in projects: [Project],
        keyPath: KeyPath<Project, Answer>
    ) -> (answer: Answer?, percent: Double) {
        let total = projects.count
        guard total > 0 else { return (nil, 0) }

        let counts = Dictionary(grouping: projects, by: { $0[keyPath: keyPath] })
            .mapValues(\.count)

        guard let (bestAnswer, bestCount) = counts.max(by: { $0.value < $1.value }) else {
            return (nil, 0)
        }

        let percent = Double(bestCount) / Double(total) * 100.0
        let rounded = (percent * 10).rounded() / 10  // 1 знак после запятой
        return (bestAnswer, rounded)
    }
    
    func mostFrequentQ1Percent() -> (answer: Answer?, percent: Double) {
        mostFrequentAnswerResult(in: self.projects, keyPath: \.queastionOneAnswer)
    }

    func mostFrequentQ2Percent() -> (answer: Answer?, percent: Double) {
        mostFrequentAnswerResult(in: self.projects, keyPath: \.queastionTwoAnswer)
    }
}
