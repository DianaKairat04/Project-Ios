import SwiftUI

struct TemplateDesignerView: View {

    @Binding var template: TemplateModel
    @EnvironmentObject var profile: ProfileData

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {

                Text("Шаблонды баптау")
                    .font(.title.bold())

                // ТҮСТЕР
                VStack(alignment: .leading, spacing: 10) {
                    Text("Түстер")
                        .font(.headline)

                    ColorPicker("Accent", selection: $template.accentColor)
                    ColorPicker("Background", selection: $template.backgroundColor)
                }

                // ШРИФТ
                VStack(alignment: .leading, spacing: 10) {
                    Text("Шрифт")
                        .font(.headline)

                    Picker("Font", selection: $template.fontStyle) {
                        ForEach(FontStyle.allCases, id: \.self) { style in
                            Text(style.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // ЛОГОТИП ОРНЫ
                VStack(alignment: .leading, spacing: 10) {
                    Text("Логотип орны")
                        .font(.headline)

                    Picker("Logo", selection: $template.logoPosition) {
                        Text("Жоғары").tag(LogoPosition.top)
                        Text("Ортасы").tag(LogoPosition.center)
                        Text("Төмен").tag(LogoPosition.bottom)
                    }
                    .pickerStyle(.segmented)
                }

                // LIVE PREVIEW МІНЕ ОСЫ ЖЕР ҚАТЕ БОЛҒАН
                CertificatePreviewView(
                    template: template,
                    data: CertificateData.example
                )
                .environmentObject(profile)
                .frame(height: 260)
                .background(Color("card"))
                .cornerRadius(12)
                .shadow(radius: 4)
                .padding(.top, 10)

            }
            .padding()
        }
        .navigationTitle("Дизайн")
    }
}
