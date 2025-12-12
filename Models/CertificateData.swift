import Foundation
import SwiftUI

struct CertificateData {
    var fullName: String = ""
    var className: String = ""
    var achievement: String = ""
    var eventName: String = ""
    var teacherName: String = ""
    var date: Date = Date()
    var signature: UIImage? = nil
    var stamp: UIImage? = nil
}

extension CertificateData {
    static var example: CertificateData {
        CertificateData(
            fullName: "Оқушы аты",
            className: "10 Ә",
            achievement: "Үздік нәтиже",
            eventName: "Мектеп олимпиадасы",
            teacherName: "Жетекші мұғалім",
            date: Date(),
            signature: nil,
            stamp: nil
        )
    }
}


