//
//  VQArchiveCellView.swift
//  V2MOM questions
//
//


import SwiftUI

struct VQArchiveCellView: View {
    let project: Project
    @ObservedObject var viewModel: VQProjectViewModel
    @State var status: ProjectStatus = .atWork
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(project.title)
                .font(.system(size: 19, weight: .bold))
                .foregroundStyle(.white)
            
            Text(formatDate(project.date))
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.white.opacity(0.5))
            
            HStack(spacing: 16) {
                Text(project.type.text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16).padding(.vertical, 8)
                    .background(Gradients.blue.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(project.status.text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16).padding(.vertical, 8)
                    .background(statusBg())
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.cellBg)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func statusBg() -> Gradient {
        switch project.status {
        case .atWork:
            Gradients.yellow.color
        case .ready:
            Gradients.green.color
        case .cancelled:
            Gradients.red.color
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    VQArchiveCellView(project: Project(vision: "", values: [], methods: [], obstacles: Obstacles(text: "text", tags: []), measures: "", queastionOneAnswer: .methods, queastionTwoAnswer: .measures, title: "Launch of eco-products ", type: .business, status: .cancelled), viewModel: VQProjectViewModel())
}
