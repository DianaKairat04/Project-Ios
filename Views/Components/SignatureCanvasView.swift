import SwiftUI
import UIKit

struct SignatureCanvasView: View {

    @Binding var image: UIImage?

    @State private var points: [CGPoint] = []

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.1))

            Path { path in
                guard points.count > 1 else { return }

                path.move(to: points[0])
                for p in points.dropFirst() {
                    path.addLine(to: p)
                }
            }
            .stroke(.black, lineWidth: 2)
        }
        .frame(height: 160)
        .cornerRadius(12)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    points.append(value.location)
                }
                .onEnded { _ in
                    saveImage()
                }
        )
    }

    private func saveImage() {
        let size = CGSize(width: 320, height: 160)
        let renderer = UIGraphicsImageRenderer(size: size)

        let img = renderer.image { ctx in
            UIColor.white.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))

            guard points.count > 1 else { return }

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(2)

            ctx.cgContext.move(to: points[0])
            for p in points.dropFirst() {
                ctx.cgContext.addLine(to: p)
            }
            ctx.cgContext.strokePath()
        }

        image = img
    }
}
