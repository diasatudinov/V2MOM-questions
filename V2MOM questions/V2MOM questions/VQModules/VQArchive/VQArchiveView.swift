//
//  VQArchiveView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQArchiveView: View {
    @Environment(\.dismiss) private var dismiss
    let project: Project
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            
            HStack(spacing: .zero) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: .zero) {
                        Image(systemName: "chevron.left")
                            .frame(height: 16)
                            .foregroundStyle(.white)
                            .padding(.trailing, 12)
                        
                        Text("Project")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }.buttonStyle(.plain)
            }.padding(.bottom, 10)
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black)
    }
}

#Preview {
    VQArchiveView(project:
                    Project(
                        vision: "",
                        values: [],
                        methods: [],
                        obstacles: Obstacles(text: "text", tags: []),
                        measures: "",
                        queastionOneAnswer: .methods,
                        queastionTwoAnswer: .measures,
                        title: "Launch of eco-products ",
                        type: .business,
                        status: .atWork)
    )
}
