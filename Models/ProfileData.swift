import SwiftUI
import Combine

final class ProfileData: ObservableObject {
    @Published var schoolLogo: UIImage?
    @Published var schoolSeal: UIImage?
    @Published var directorSignature: UIImage?
}
