//
//  VQQuestionView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQQuestionView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: VQProjectViewModel
    let title: String
    let type: ProjectType
    let status: ProjectStatus
    @State private var page: Int = 0
    @State private var questionNum: Int = 0
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
    @State private var queastionOneAnswer: Answer?
    @State private var queastionTwoAnswer: Answer?
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    
    private var navBarText: String {
        switch page {
        case 0:
            "Vision"
        case 1:
            "Values"
        case 2:
            "Methods"
        case 3:
            "Obstacles"
        case 4:
            "Measures"
        default:
            ""
        }
    }
    
    private var viewBg: Gradient {
        switch page {
        case 0:
            Gradients.yellow.color
        case 1:
            Gradients.green.color
        case 2:
            Gradients.purple.color
        case 3:
            Gradients.red.color
        case 4:
            Gradients.blue.color
        case 5:
            Gradient(colors: [.black])
        case 6:
            Gradient(colors: [.black])
        default:
            Gradients.blue.color
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            if page == 5 {
                finalPage()
            } else if page == 6 {
                surveyPage()
            } else {
                HStack(spacing: .zero) {
                    Button {
                        backButtonTap()
                    } label: {
                        HStack(spacing: .zero) {
                            Image(systemName: "chevron.left")
                                .frame(height: 16)
                                .foregroundStyle(.white)
                                .padding(.trailing, 20)
                            
                            Text(navBarText)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }.buttonStyle(.plain)
                    
                }.padding(.bottom, 10)
                
                Rectangle()
                    .foregroundStyle(.white.opacity(0.25))
                    .frame(height: 4)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: lineWidth())
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, -24)
                    .padding(.bottom)
                
                bodyView()
                
                Button {
                    nextButtonTap()
                } label: {
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(arePagesValid() ? btnLabelColor() : .white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 13)
                        .background(arePagesValid() ? .white: .cellBg.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 60)
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16).padding(.horizontal, 24)
        .background(viewBg)
    }
    
    private func backButtonTap() {
        if page > 0 {
            page -= 1
        } else {
            viewModel.openCreateProjectFlow = false
        }
    }
    
    private func nextButtonTap() {
        if page < 5 && arePagesValid() {
            page += 1
        }
    }
    
    private func lineWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let onePart = screenWidth / 5
        return onePart * CGFloat(page + 1)
    }
    
    private func pageOneBody() -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            VStack(spacing: 10) {
                Text("Where do we want to go?")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
            }
            .padding(.leading)
            .padding(.top)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
            }
            
            TextEditor(text: $vision)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                )
                .scrollContentBackground(.hidden)
                .overlay(alignment: .topLeading) {
                    if vision.isEmpty {
                        Text("Text")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.5))
                            .allowsHitTesting(false)
                            .padding(17)
                    }
                }
                
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: UIScreen.main.bounds.height / 2 - 50)
        .background(.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func pageTwoBody() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 10) {
                Text("What is indisputable for us on this path?")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
            }
            .padding(.leading)
            .padding(.top)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
            }
            
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .foregroundStyle(.white)
                    .bold()
                
                TextField("", text: $value)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .overlay(alignment: .topLeading) {
                        if value.isEmpty {
                            Text("Text")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.5))
                                .allowsHitTesting(false)
                            
                        }
                    }
                
                Button {
                    sendPressed()
                } label: {
                    Image("send.arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 16)
                        .opacity(value.isEmpty ? 0.5 : 1)
                }.buttonStyle(.plain)
            }
            .padding(.vertical, 12).padding(.horizontal, 16)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(values, id: \.self) { item in
                        HStack {
                            Text(item.text)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 10)
                                .foregroundStyle(.black.opacity(0.3))
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12).padding(.horizontal, 6)
                        .background(
                            Gradients.green.color
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            deleteValue(item)
                        }
                    }
                }.padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: UIScreen.main.bounds.height / 3 - 10)
        .background(.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func pageThreeBody() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 10) {
                Text("What are the 3–5 key actions that will lead us to our goal?")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
            }
            .padding(.leading)
            .padding(.top)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
            }
            
            VStack {
                ForEach(methods.indices, id: \.self) { i in
                    HStack(spacing: 8) {
                        Text("\(i + 1).")
                            .foregroundStyle(methods[i].text.isEmpty ? .white.opacity(0.5) : .white)
                        TextField("", text: $methods[i].text)
                            .foregroundStyle(.white)
                            .overlay(alignment: .topLeading) {
                                if methods[i].text.isEmpty {
                                    Text("Text")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.white.opacity(0.5))
                                        .allowsHitTesting(false)
                                    
                                }
                            }
                    }.font(.system(size: 16, weight: .semibold))
                }
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: UIScreen.main.bounds.height / 3 - 10)
        .background(.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func pageFourBody() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 10) {
                Text("What could get in the way?")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
            }
            .padding(.leading)
            .padding(.top)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
            }
            
            TextEditor(text: $obstacleText)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(height: 150)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                )
                .scrollContentBackground(.hidden)
                .overlay(alignment: .topLeading) {
                    if obstacleText.isEmpty {
                        Text("Text")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.5))
                            .allowsHitTesting(false)
                            .padding(8)
                            .padding(.leading, 8)
                    }
                }
            
            VStack(spacing: 16) {
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
                    .padding(.trailing)
                
                HStack(spacing: 12) {
                    ForEach(ObstacleTag.allCases, id: \.self) { tag in
                        
                        Text(tag.text)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 8).padding(.horizontal, 16)
                            .background(obstacleTags.contains(tag) ? Gradients.red.color : Gradient(colors: [.clear]))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                if !obstacleTags.contains(tag) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 2)
                                        .foregroundStyle(.white)
                                }
                            }
                            .onTapGesture {
                                tagPressed(tag: tag)
                            }
                    }
                }.padding(.horizontal)
            }.padding(.bottom)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func pageFiveBody() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 10) {
                Text("How will we know when we have achieved our goal?")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
            }
            .padding(.leading)
            .padding(.top)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
            }
            
            TextEditor(text: $measures)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(height: 150)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                )
                .scrollContentBackground(.hidden)
                .overlay(alignment: .topLeading) {
                    if measures.isEmpty {
                        Text("Text")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.5))
                            .allowsHitTesting(false)
                            .padding(8)
                            .padding(.leading, 8)
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func finalPage() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Final scorecard")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    
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
                        
                        Text(vision)
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
                            ForEach(values, id: \.self) { item in
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
                        
                        ForEach(methods.indices, id: \.self) { i in
                            if !methods[i].text.isEmpty {
                                HStack(spacing: 8) {
                                    Text("\(i + 1).")
                                        .foregroundStyle(.white)
                                    Text(methods[i].text)
                                        .foregroundStyle(.white)
                                        .overlay(alignment: .topLeading) {
                                            if methods[i].text.isEmpty {
                                                Text("Text")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundStyle(.white.opacity(0.5))
                                                    .allowsHitTesting(false)
                                                
                                            }
                                        }
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
                            
                            Text(obstacleText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            HStack(spacing: 12) {
                                ForEach(obstacleTags, id: \.self) { tag in
                                    
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
                            
                            Text(measures)
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
            
            Button {
                page = 0
            } label: {
                Text("Edit")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Gradients.yellow.color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Text("Ready for the project?")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 22) {
                Button {
                    noPressed()
                } label: {
                    Text("No")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(Gradients.red.color)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Button {
                    yesPressed()
                } label: {
                    Text("Yes")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(Gradients.green.color)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var questionText: String {
        switch questionNum {
        case 0:
            "Which point was the most understandable?"
        case 1:
            "Which point was the most understandable?"
        default:
            ""
        }
    }
    
    private var surveyBtnText: String {
        switch questionNum {
        case 0:
            "Next"
        case 1:
            "Save"
        default:
            ""
        }
    }
    
    private func surveyPage() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Survey")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading) {
                Text(questionText)
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.white)
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Answer.allCases, id: \.self) { answer in
                        Text(answer.text)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 12).padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(isCorrect(answer: answer) ? answerBtnColor(answer: answer) : Gradient(colors: [.textFieldBg]))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                onAnswerTapped(answer: answer)
                            }

                    }
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.newProjectBg)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Button {
                onSurveyBtnTap()
            } label: {
                Text(surveyBtnText)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(isSurveyValid() ? .white : .white.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(isSurveyValid() ? Gradients.yellow.color : Gradient(colors: [.newProjectBg]))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 40)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func onAnswerTapped(answer: Answer) {
        switch questionNum {
        case 0:
            queastionOneAnswer = answer
        case 1:
            queastionTwoAnswer = answer
        default: break
            
        }
    }
    
    private func onSurveyBtnTap() {
        
        switch questionNum {
        case 0:
            if isSurveyValid() {
                questionNum += 1
            }
        case 1:
            if isSurveyValid() {
                let project = Project(
                    vision: vision,
                    values: values,
                    methods: methods,
                    obstacles: Obstacles(text: obstacleText, tags: obstacleTags),
                    measures: measures,
                    queastionOneAnswer: queastionOneAnswer ?? .values,
                    queastionTwoAnswer: queastionOneAnswer ?? .values,
                    title: title,
                    type: type,
                    status: status
                )
                
                viewModel.add(project)
                viewModel.openCreateProjectFlow = false
            }
        default:
            break
        }
    }
    
    private func answerBtnColor(answer: Answer) -> Gradient {
        switch answer {
        case .vision:
            Gradients.yellow.color
        case .values:
            Gradients.green.color
        case .obstacles:
            Gradients.red.color
        case .methods:
            Gradients.purple.color
        case .measures:
            Gradients.blue.color
        }
    }
    
    private func isCorrect(answer: Answer) -> Bool {
        switch questionNum {
        case 0:
            queastionOneAnswer == answer
        case 1:
            queastionTwoAnswer == answer
        default:
            false
        }
    }
    
    private func isSurveyValid() -> Bool {
        switch questionNum {
        case 0:
            queastionOneAnswer != nil
        case 1:
            queastionTwoAnswer != nil
        default:
            false
        }
    }
    
    @ViewBuilder private func bodyView() -> some View {
        switch page {
        case 0:
            pageOneBody()
        case 1:
            pageTwoBody()
        case 2:
            pageThreeBody()
        case 3:
            pageFourBody()
        case 4:
            pageFiveBody()
            
        default:
            pageOneBody()
        }
    }
    
    private func arePagesValid() -> Bool {
        switch page {
        case 0:
            !vision.isEmpty
        case 1:
            !values.isEmpty
        case 2:
            methods.contains { !$0.text.isEmpty }
        case 3:
            !obstacleText.isEmpty
        case 4:
            !measures.isEmpty
            
        default:
            false
        }
    }
    
    private func btnLabelColor() -> Color {
        switch page {
        case 0:
                .btnYellow
        case 1:
                .btnGreen
        case 2:
                .btnPurple
        case 3:
                .btnRed
        case 4:
                .btnBlue
            
        default:
                .white
        }
    }
    
    private func deleteValue(_ value: Value) {
        if let index = values.firstIndex(where: { $0.id == value.id }) {
            values.remove(at: index)
        }
    }
    
    private func addValue(_ value: Value) {
        values.append(value)
    }
    
    private func sendPressed() {
        if !value.isEmpty {
            let value = Value(text: self.value)
            addValue(value)
            self.value = ""
        }
    }
    
    private func tagPressed(tag: ObstacleTag) {
        if !obstacleTags.contains(tag) {
            obstacleTags.append(tag)
        } else {
            if let index = obstacleTags.firstIndex(where: { $0 == tag }) {
                obstacleTags.remove(at: index)
            }
        }
    }
    
    private func yesPressed() {
        page += 1
        
    }
    
    private func noPressed() {
        let project = Project(
            vision: vision,
            values: values,
            methods: methods,
            obstacles: Obstacles(text: obstacleText, tags: obstacleTags),
            measures: measures,
            queastionOneAnswer: .vision,
            queastionTwoAnswer: .vision,
            title: title,
            type: type,
            status: .cancelled
        )
        
        viewModel.add(project)
        viewModel.openCreateProjectFlow = false
    }
}

#Preview {
    VQQuestionView(viewModel: VQProjectViewModel(), title: "Blog", type: .personal, status: .atWork)
}

