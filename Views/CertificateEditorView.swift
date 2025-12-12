import SwiftUI

struct CertificateEditorView: View {

    @ObservedObject var viewModel: EditorViewModel
    @EnvironmentObject var profile: ProfileData
    @EnvironmentObject var templateStore: TemplateStore   // Таңдалған шаблон осыдан алынады

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // INPUT FIELDS
                inputFieldsSection

                // PREVIEW
                CertificatePreviewView(
                    template: viewModel.template,
                    data: viewModel.data
                )
                .environmentObject(profile)
                .frame(height: 260)
                .background(Color("card"))
                .cornerRadius(12)
                .shadow(radius: 4)

                // PDF EXPORT BUTTON
                PrimaryButton(title: "PDF экспорт", icon: "doc.fill") {
                    if viewModel.validate() {

                        let preview = CertificatePreviewView(
                            template: viewModel.template,
                            data: viewModel.data
                        )
                        .environmentObject(profile)

                        PDFRenderer.export(view: preview)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Сертификат")
    }

    // MARK: - Input Section
    var inputFieldsSection: some View {
        VStack(spacing: 12) {

            TextField("Оқушы аты", text: $viewModel.data.fullName)
                .textFieldStyle(.roundedBorder)

            TextField("Жетістігі", text: $viewModel.data.achievement)
                .textFieldStyle(.roundedBorder)

            TextField("Іс-шара", text: $viewModel.data.eventName)
                .textFieldStyle(.roundedBorder)

            TextField("Мұғалім", text: $viewModel.data.teacherName)
                .textFieldStyle(.roundedBorder)

            DatePicker("Күні",
                       selection: $viewModel.data.date,
                       displayedComponents: .date)
        }
        .padding()
        .background(Color("card"))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
