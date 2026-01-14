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
//    func editCheck(project: Project, name: String, type: ChecklistType) {
//        if let index = checks.firstIndex(where: { $0.id == check.id }) {
//            checks[index].name = name
//            checks[index].type = type
//        }
//    }
    
    func delete(project: Project) {
        guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
        projects.remove(at: index)
    }
}
