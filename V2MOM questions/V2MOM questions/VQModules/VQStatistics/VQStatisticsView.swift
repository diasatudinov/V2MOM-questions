//
//  VQStatisticsView.swift
//  V2MOM questions
//
//

import SwiftUI

struct VQStatisticsView: View {
    @ObservedObject var viewModel: VQProjectViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Statistics")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Results: ")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("Total projects: \(viewModel.projects.count)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("Completed: \(viewModel.count(for: .ready)) (\(formattedDouble(viewModel.percent(for: .ready)))%)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.btnGreen)
                            Text("Cancelled: \(viewModel.count(for: .cancelled)) (\(formattedDouble(viewModel.percent(for: .cancelled)))%)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.btnRed)
                            Text("At work: \(viewModel.count(for: .atWork)) (\(formattedDouble(viewModel.percent(for: .atWork)))%)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.btnYellow)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        let slicesData = slices(from: viewModel.projects)
                        let total = Double(viewModel.projects.count)

                        VStack(spacing: 16) {
                            DonutChartView(slices: slicesData)
                                .frame(height: 150)
                        }
                        
                        
                    }
                    .padding()
                    .background(.cellBg)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                       
                    VStack {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Point-by-point analysis:")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("The most understandable point: \(viewModel.mostFrequentQ1Percent().answer?.text ?? "-") (\(formattedDouble(viewModel.mostFrequentQ1Percent().percent))%)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.btnGreen)
                            
                            let barsQ1 = answerDistribution(projects: viewModel.projects, keyPath: \.queastionOneAnswer)

                            AnswerBarChartView(title: "Question 1", bars: barsQ1)

                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                    .padding()
                    .background(.cellBg)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Point-by-point analysis:")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("The most difficult: \(viewModel.mostFrequentQ2Percent().answer?.text ?? "-") (\(formattedDouble(viewModel.mostFrequentQ2Percent().percent))%) ")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.btnRed)
                            
                            let barsQ2 = answerDistribution(projects: viewModel.projects, keyPath: \.queastionTwoAnswer)

                            AnswerBarChartView(title: "Question 2", bars: barsQ2)

                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                    .padding()
                    .background(.cellBg)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                }.padding(.bottom, 90)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16).padding(.horizontal, 24)
        .background(.black)
    }
    
    func formattedDouble(_ num: Double) -> String {
        String(format: "%.1f", num)
    }
}

#Preview {
    VQStatisticsView(viewModel: VQProjectViewModel())
}



import SwiftUI
import Charts

struct AnswerBarChartView: View {
    let title: String
    let bars: [AnswerBar]

    var body: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading, spacing: 12) {
                
                Chart(bars) { item in
                    BarMark(
                        x: .value("Answer", item.answer.text),
                        y: .value("Percent", item.percent),
                        width: .fixed(10)
                    )
                    .foregroundStyle(answerBtnColor(answer: item.answer))
                }
                
                .chartYScale(domain: 0...100)
                .chartXAxis {
                    AxisMarks { _ in
                        AxisValueLabel().foregroundStyle(.white)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisValueLabel()
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 75, height: 210)
            }
            .padding(.vertical)
            .clipShape(RoundedRectangle(cornerRadius: 16))
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
}
