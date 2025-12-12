import SwiftUI
import Combine 

final class EditorViewModel: ObservableObject {
    @Published var data = CertificateData()
    @Published var template: TemplateModel

    @Published var showError = false
    @Published var errorText = ""

    init(template: TemplateModel) {
        self.template = template
    }

    func validate() -> Bool {
        if data.fullName.isEmpty {
            errorText = "Аты-жөні толтырылмаған"
            showError = true
            return false
        }
        if data.achievement.isEmpty {
            errorText = "Жетістігі көрсетілмеген"
            showError = true
            return false
        }
        return true
    }
}


