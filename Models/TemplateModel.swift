import SwiftUI

enum FontStyle: String, CaseIterable {
    case regular, bold, italic
}

enum LogoPosition: String, CaseIterable {
    case top, center, bottom
}



import SwiftUI

struct TemplateModel: Identifiable, Hashable {
    let id = UUID()

    var name: String
    var category: String
    var description: String

    var accentColor: Color
    var backgroundColor: Color
    var fontStyle: FontStyle
    var logoPosition: LogoPosition
    var backgroundImage: String?
}


