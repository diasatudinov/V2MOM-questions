//
//  VQArchiveView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQArchiveView: View {
    @Environment(\.dismiss) private var dismiss
    let project: Project
    
    @State private var title: String = ""
    @State private var type: ProjectType = .business
    @State private var status: ProjectStatus = .atWork
    @State private var isTitleValid: Bool = true
    @State private var vision: String = ""
    @State private var value: String = ""
    @State private var values: [Value] = []
    @State private var methods: [Method] = [
        .init(text: ""),
        .init(text: ""),
        .init(text: ""),
        .init(text: ""),
        .init(text: "")
    ]
    @State private var obstacleText: String = ""
    @State private var obstacleTags: [ObstacleTag] = []
    @State private var measures: String = ""
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    private var statusColor: Gradient {
        switch project.status {
        case .atWork:
            Gradients.yellow.color
        case .ready:
            Gradients.green.color
        case .cancelled:
            Gradients.red.color
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: .zero) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: .zero) {
                        Image(systemName: "chevron.left")
                            .frame(height: 16)
                            .foregroundStyle(.white)
                            .padding(.trailing, 12)
                        
                        Text("Archive")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }.buttonStyle(.plain)
            }
            
            ScrollView {
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Title:")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text(project.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 12).padding(.horizontal, 16)
                            .background(.textFieldBg)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Type:")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundStyle(.white)
                        
                        HStack(spacing: 13) {
                            ForEach(ProjectType.allCases) { type in
                                
                                if type == project.type {
                                    Text(type.text)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 8).padding(.horizontal, 20)
                                        .background(Gradients.blue.color)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    Text(type.text)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.white.opacity(0.5))
                                        .padding(.vertical, 8).padding(.horizontal, 16)
                                }
                                
                            }
                        }
                        .padding(8)
                        .background(.textFieldBg)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Status:")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundStyle(.white)
                        
                        HStack(spacing: 13) {
                            ForEach(ProjectStatus.allCases) { status in
                                
                                if status == project.status {
                                    Text(status.text)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 8).padding(.horizontal, 20)
                                        .background(statusColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    
                                } else {
                                    Text(status.text)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.white.opacity(0.5))
                                        .padding(.vertical, 8).padding(.horizontal, 16)
                                }
                                
                            }
                        }
                        .padding(8)
                        .background(.textFieldBg)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding()
                .background(.newProjectBg)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                
                VStack(spacing: 24) {
                    
                    VStack(spacing: 12) {
                        VStack(spacing: 10) {
                            HStack(spacing: 8) {
                                Image(.visionIconVQ)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text("Vision")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.white)
                                .padding(.horizontal, -16)
                        }
                        
                        Text(project.vision)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Gradients.yellow.color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(spacing: 12) {
                        VStack(spacing: 10) {
                            HStack(spacing: 8) {
                                Image(.valuesIconVQ)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text("Values")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.white)
                                .padding(.horizontal, -16)
                        }
                        
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(project.values, id: \.self) { item in
                                HStack {
                                    Text(item.text)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12).padding(.horizontal, 6)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(lineWidth: 2)
                                        .foregroundStyle(.white)
                                })
                                
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Gradients.green.color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(spacing: 12) {
                        VStack(spacing: 10) {
                            HStack(spacing: 8) {
                                Image(.methodsIconVQ)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text("Methods")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.white)
                                .padding(.horizontal, -16)
                        }
                        
                        ForEach(project.methods.indices, id: \.self) { i in
                            if !project.methods[i].text.isEmpty {
                                HStack(spacing: 8) {
                                    Text("\(i + 1).")
                                        .foregroundStyle(.white)
                                    Text(project.methods[i].text)
                                        .foregroundStyle(.white)
                                }
                                .font(.system(size: 16, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Gradients.purple.color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(spacing: 12) {
                        VStack(spacing: 10) {
                            HStack(spacing: 8) {
                                Image(.obstaclesIconVQ)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text("Obstacles")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.white)
                                .padding(.horizontal, -16)
                        }
                        
                        VStack(spacing: 8) {
                            
                            Text(project.obstacles.text)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            HStack(spacing: 12) {
                                ForEach(project.obstacles.tags, id: \.self) { tag in
                                    
                                    Text(tag.text)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 8).padding(.horizontal, 16)
                                        .background(Gradient(colors: [.clear]))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(lineWidth: 2)
                                                .foregroundStyle(.white)
                                            
                                        }
                                }
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Gradients.red.color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    
                    VStack(spacing: 12) {
                        VStack(spacing: 10) {
                            HStack(spacing: 8) {
                                Image(.measuresIconVQ)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text("Measures")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.white)
                                .padding(.horizontal, -16)
                        }
                        
                        VStack(spacing: 8) {
                            
                            Text(project.measures)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Gradients.blue.color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black)
    }
}

#Preview {
    VQArchiveView(project:
                    Project(
                        vision: "sadadas adsdsad asdsad",
                        values: [Value(text: "sadsad"), Value(text: "sadsad"), Value(text: "sadsad"), Value(text: "sadsad")],
                        methods: [Method(text: "das"), Method(text: "das"), Method(text: "das"), Method(text: "das"), Method(text: "das"), Method(text: "das")],
                        obstacles: Obstacles(text: "text", tags: [ObstacleTag.budget]),
                        measures: "asdsadsa",
                        queastionOneAnswer: .methods,
                        queastionTwoAnswer: .measures,
                        title: "Launch of eco-products ",
                        type: .personal,
                        status: .cancelled)
    )
}
