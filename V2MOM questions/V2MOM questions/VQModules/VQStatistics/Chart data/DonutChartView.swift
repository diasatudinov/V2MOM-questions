//
//  DonutChartView.swift
//  V2MOM questions
//
//
import SwiftUI

struct DonutChartView: View {
    let slices: [StatusSlice]
    let lineWidth: CGFloat = 10

    // задай свои цвета как хочешь
    private func color(for status: ProjectStatus) -> Color {
        switch status {
        case .atWork: return .orange
        case .ready: return .green
        case .cancelled: return .red
        }
    }

    var body: some View {
        let total = slices.map(\.value).reduce(0, +)

        ZStack {
            if total == 0 {
                Circle()
                    .stroke(.gray.opacity(0.25), lineWidth: lineWidth)
                Text("0")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            } else {
                Canvas { context, size in
                    let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth/2, dy: lineWidth/2)
                    let center = CGPoint(x: size.width/2, y: size.height/2)
                    let radius = min(rect.width, rect.height) / 2

                    var startAngle = -Double.pi / 2 // старт сверху

                    for slice in slices where slice.value > 0 {
                        let fraction = slice.value / total
                        let endAngle = startAngle + 2 * Double.pi * fraction

                        var path = Path()
                        path.addArc(center: center,
                                    radius: radius,
                                    startAngle: .radians(startAngle),
                                    endAngle: .radians(endAngle),
                                    clockwise: false)

                        // это превращает дугу в “бублик” за счёт stroke
                        context.stroke(path,
                                       with: .color(color(for: slice.status)),
                                       style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))

                        startAngle = endAngle
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}
