//
//  VQMenuView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQMenuView: View {
    @State var selectedTab = 0
    @StateObject var viewModel = VQProjectViewModel()
    private let tabs = ["", "",""]
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                VQProjectView(viewModel: viewModel)
            case 1:
                VQArchivesView(viewModel: viewModel)
            case 2:
                VQStatisticsView(viewModel: viewModel)
            default:
                Text("default")
            }
            
            VStack {
                Spacer()
                
                HStack {
                    ForEach(0..<tabs.count) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            VStack(spacing: 2) {
                                Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 30)
                                
                                Text(text(for: index))
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundStyle(selectedTab == index ? .tabAccent : .tabSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                    }
                }
                .padding(.horizontal, 16).padding(.vertical, 10)
                .background(.black)
            }
            .padding(.bottom, 24)
            .ignoresSafeArea()
            
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconVQ"
        case 1: return "tab2IconVQ"
        case 2: return "tab3IconVQ"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelectedVQ"
        case 1: return "tab2IconSelectedVQ"
        case 2: return "tab3IconSelectedVQ"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "Project"
        case 1: return "Atchive"
        case 2: return "Statistics"
        default: return ""
        }
    }
}

#Preview {
    NavigationStack {
        VQMenuView()
    }
}

