import SwiftUI

struct CertificatePreviewView: View {

    let template: TemplateModel
    let data: CertificateData

    @EnvironmentObject var profile: ProfileData

    var body: some View {

        ZStack {
            // 🔵 ФОН СУРЕТ (ЕГЕР БАР БОЛСА)
            if let bgName = template.backgroundImage {
                Image(bgName)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }

            // 🔵 ФОН ТҮС
            template.backgroundColor.opacity(0.85)

            // 🔵 КОНТЕНТ
            VStack(spacing: 12) {

                // ЛОГО ОРНЫ
                if let logo = profile.schoolLogo, template.logoPosition == .top {
                    Image(uiImage: logo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 55)
                }

                // TITLE
                Text("CERTIFICATE")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(template.accentColor)

                Text(data.fullName.isEmpty ? "Оқушының аты" : data.fullName)
                    .font(.system(size: 22, weight: .bold))

                Text(data.achievement.isEmpty ? "Жетістігі" : data.achievement)
                    .foregroundColor(.gray)

                if !data.eventName.isEmpty {
                    Text(data.eventName)
                        .foregroundColor(.gray)
                }

                Text("Күні: \(formattedDate)")
                    .foregroundColor(.gray)

                if !data.teacherName.isEmpty {
                    Text("Жетекші: \(data.teacherName)")
                        .foregroundColor(.gray)
                }

                Spacer()

                // МӨР + ҚОЛ
                HStack {
                    if let seal = profile.schoolSeal {
                        Image(uiImage: seal)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                    }

                    Spacer()

                    if let signature = profile.directorSignature {
                        Image(uiImage: signature)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                    }
                }
            }
            .padding()
        }
        .frame(height: 280)
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: data.date)
    }
}
