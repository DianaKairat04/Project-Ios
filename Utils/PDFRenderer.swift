import SwiftUI
import UIKit

struct PDFRenderer {

    // ================================
    //   1) БІР БЕТТІ PDF ШЫҒАРУ
    // ================================
    static func export(view: some View) {

        let renderer = ImageRenderer(content:
            view.frame(width: 794, height: 1123) // A4 өлшемі
        )

        guard let image = renderer.uiImage else {
            print("❌ Image render failed")
            return
        }

        let pdfData = NSMutableData()
        var mediaBox = CGRect(x: 0, y: 0, width: 794, height: 1123)

        guard let consumer = CGDataConsumer(data: pdfData as CFMutableData),
              let context = CGContext(consumer: consumer, mediaBox: &mediaBox, nil)
        else { return }

        context.beginPDFPage(nil)
        image.draw(in: mediaBox)
        context.endPDFPage()
        context.closePDF()

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("certificate.pdf")

        pdfData.write(to: url, atomically: true)

        print("✅ Бір сертификат PDF дайын:", url)
    }

    // ================================
    //   2) КӨП БЕТТІ PDF (100+)
    // ================================
    static func exportBatch(views: [some View]) {

        let pdfData = NSMutableData()
        let pageRect = CGRect(x: 0, y: 0, width: 794, height: 1123)

        guard let consumer = CGDataConsumer(data: pdfData as CFMutableData) else { return }
        var mediaBox = pageRect

        guard let context = CGContext(consumer: consumer, mediaBox: &mediaBox, nil)
        else { return }

        for view in views {
            let renderer = ImageRenderer(content:
                view.frame(width: 794, height: 1123)
            )

            if let image = renderer.uiImage {
                context.beginPDFPage(nil)
                image.draw(in: mediaBox)
                context.endPDFPage()
            }
        }

        context.closePDF()

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("batch_certificates.pdf")

        pdfData.write(to: url, atomically: true)

        print("✅ Batch PDF дайын:", url)
    }
}
