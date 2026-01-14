//
//  VQArchiveView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQArchiveView: View {
    @ObservedObject var viewModel: VQProjectViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Archive")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    ForEach(viewModel.projects.filter({ $0.status != .atWork }), id: \.id) { project in
                        VQArchiveCellView(project: project, viewModel: viewModel)

                    }
                }.padding(.bottom, 90)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16).padding(.horizontal, 24)
        .background(.black)

    }
}

#Preview {
    VQArchiveView(viewModel: VQProjectViewModel())
}
