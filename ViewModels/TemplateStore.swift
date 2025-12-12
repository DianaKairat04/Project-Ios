import SwiftUI
import Combine

final class TemplateStore: ObservableObject {

    @Published var templates: [TemplateModel] = []

    init() {
        templates = [
            TemplateModel(
                name: "Sport Certificate",
                category: "🏆 Sport",
                description: "Жарыс жеңімпаздарына арналған",
                accentColor: .orange,
                backgroundColor: .white,
                fontStyle: .regular,
                logoPosition: .top,
                backgroundImage: nil
            ),
            TemplateModel(
                name: "Thank You",
                category: "📜 Thanks",
                description: "Алғыс хат",
                accentColor: .blue,
                backgroundColor: .white,
                fontStyle: .regular,
                logoPosition: .top,
                backgroundImage: nil
            ),
            TemplateModel(
                name: "School Diploma",
                category: "🎓 Diploma",
                description: "Үздік оқушы дипломы",
                accentColor: .purple,
                backgroundColor: .white,
                fontStyle: .regular,
                logoPosition: .top,
                backgroundImage: nil
            )
        ]
    }
}
