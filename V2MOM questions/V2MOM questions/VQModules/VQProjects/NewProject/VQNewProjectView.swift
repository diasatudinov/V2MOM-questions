//
//  VQNewProjectView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQNewProjectView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: VQProjectViewModel

    @State private var title: String = ""
    @State private var type: ProjectType = .business
    @State private var status: ProjectStatus = .atWork
    @State private var isTitleValid: Bool = true
    
    @State private var goToQuestions = false
    
    private var statusColor: Gradient {
        switch status {
        case .atWork:
            Gradients.yellow.color
        case .ready:
            Gradients.green.color
        case .cancelled:
            Gradients.red.color
        }
    }
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
            
                VStack(spacing: 8) {
                    
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Title:")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundStyle(.white)
                            
                            TextField("", text: $title)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.vertical, 12).padding(.horizontal, 16)
                                .background(.textFieldBg)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .topLeading) {
                                    if title.isEmpty {
                                        Text("Text")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.white.opacity(0.5))
                                            .allowsHitTesting(false)
                                            .padding(.vertical, 12).padding(.horizontal, 16)
                                        
                                    }
                                }
                                .overlay {
                                    if !isTitleValid {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(lineWidth: 2)
                                            .foregroundStyle(.red)
                                    }
                                }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Type:")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundStyle(.white)

                            HStack(spacing: 13) {
                                ForEach(ProjectType.allCases) { type in
                                    Button {
                                        self.type = type
                                    } label: {
                                        if type == self.type {
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
                                    Button {
                                        self.status = status
                                    } label: {
                                        if status == self.status {
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
                            }
                            .padding(8)
                            .background(.textFieldBg)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding()
                    .background(.newProjectBg)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            
             
            Button {
                if isValid() {
                    goToQuestions = true
                }
                
            } label: {
                Text("Next")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Gradients.yellow.color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 40)
            .onChange(of: title) { _ in
                isTitleValid = true
            }
            .navigationDestination(isPresented: $goToQuestions) {
                VQQuestionView(viewModel: viewModel, title: title, type: type, status: status)
                    .navigationBarBackButtonHidden()
            }
            
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black)
    }
    
    private func isValid() -> Bool {
        if title.isEmpty {
            isTitleValid = false
        }
        return !title.isEmpty
    }
}

#Preview {
    NavigationStack {
        VQNewProjectView(viewModel: VQProjectViewModel())
    }
}
