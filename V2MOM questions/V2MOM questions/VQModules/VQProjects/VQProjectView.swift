//
//  VQProjectView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQProjectView: View {
    @ObservedObject var viewModel: VQProjectViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("List of projects")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    ForEach(viewModel.projects.filter({ $0.status == .atWork }), id: \.id) { project in
                        VQProjectCellView(project: project, viewModel: viewModel)

                    }
                }.padding(.bottom, 90)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16).padding(.horizontal, 24)
        .background(.black)
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.openCreateProjectFlow = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 16)
                    
                    Text("New project")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 24).padding(.vertical, 12)
                .background(Gradients.yellow.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }.padding(.bottom, 80)
                .padding(.trailing)
            
        }
        .navigationDestination(isPresented: $viewModel.openCreateProjectFlow) {
            VQNewProjectView(viewModel: viewModel)
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationStack {
        VQProjectView(viewModel: VQProjectViewModel())
    }
}
