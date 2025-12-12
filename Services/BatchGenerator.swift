import SwiftUI
import PDFKit

struct BatchGenerator {

    static func exportBatchPDF(template: TemplateModel, students: [CertificateData]) {
        let pdfMeta = [
            kCGPDFContextCreator: "SchoolCert",
        ]

        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMeta as [String: Any]

        let pageSize = CGSize(width: 800, height: 1100)

        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize), format: format)

        let data = renderer.pdfData { ctx in
            for student in students {
                ctx.beginPage()

                let view = CertificatePreviewView(template: template, data: student)
                    .frame(width: pageSize.width, height: pageSize.height)

                let renderer = ImageRenderer(content: view)
                if let img = renderer.uiImage {
                    img.draw(in: CGRect(origin: .zero, size: pageSize))
                }
            }
        }

        let url = FileManager.default.temporaryDirectory.appendingPathComponent("BatchCertificates.pdf")

        try? data.write(to: url)
        print("Batch exported:", url)
    }
}

