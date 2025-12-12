import SwiftUI
import UniformTypeIdentifiers

struct BatchGeneratorView: View {

    @State private var showImporter = false
    @State private var importedStudents: [CertificateData] = []

    @EnvironmentObject var store: TemplateStore
    @EnvironmentObject var profile: ProfileData

    @State private var selectedTemplate: TemplateModel?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Text("Batch Generator")
                    .font(.title.bold())

                //  CSV / Excel жүктеу кнопкасы
                PrimaryButton(
                    title: "CSV / Excel жүктеу",
                    icon: "square.and.arrow.down"
                ) {
                    showImporter = true
                }

                // CSV жүктелсе хабарлама шығару
                if !importedStudents.isEmpty {
                    Text("✅ \(importedStudents.count) оқушы жүктелді")
                        .foregroundColor(.green)
                        .font(.headline)
                }

                // Шаблон таңдау
                if !store.templates.isEmpty {
                    Picker("Шаблон", selection: $selectedTemplate) {
                        Text("Таңдаңыз").tag(Optional<TemplateModel>(nil))
                        ForEach(store.templates) { template in
                            Text(template.name).tag(Optional(template))
                        }
                    }
                    .pickerStyle(.menu)
                }

                // PDF шығару кнопкасы
                if selectedTemplate != nil && !importedStudents.isEmpty {
                    PrimaryButton(
                        title: "PDF шығару",
                        icon: "doc.richtext"
                    ) {
                        exportBatchPDF()
                    }
                }
            }
            .padding()
        }

        // Негізгі — файл таңдағыш ДҰРЫС ЖҰМЫС ІСТЕУІ ҮШІН ОСЫ ЖЕРДЕ ТҰРУ КЕРЕК
        .fileImporter(
            isPresented: $showImporter,
            allowedContentTypes: [.plainText, .commaSeparatedText],
            allowsMultipleSelection: false
        ) { result in
            handleImport(result)
        }

        .navigationTitle("Batch Generator")
    }

    // MARK: - Файл ЖҮКТЕУ обработкасы
    func handleImport(_ result: Result<[URL], Error>) {
        do {
            let urls = try result.get()
            guard let fileURL = urls.first else { return }

            print("📥 Файл алынды:", fileURL)

            importedStudents = CSVParser.parse(url: fileURL)

            print("📥 \(importedStudents.count) оқушы табылды")

        } catch {
            print("❌ Файл жүктеу қатесі:", error.localizedDescription)
        }
    }

    // MARK: - PDF шығару
    func exportBatchPDF() {
        guard let template = selectedTemplate else { return }

        let views = importedStudents.map { student in
            CertificatePreviewView(
                template: template,
                data: student
            )
            .environmentObject(profile)
        }

        PDFRenderer.exportBatch(views: views)
    }
}
