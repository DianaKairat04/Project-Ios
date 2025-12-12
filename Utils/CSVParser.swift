import Foundation

struct CSVParser {

    static func parse(url: URL) -> [CertificateData] {

        guard let content = try? String(contentsOf: url, encoding: .utf8) else {
            print("❌ CSV оқылмады")
            return []
        }

        let rows = content.components(separatedBy: .newlines)
        var result: [CertificateData] = []

        for i in 1..<rows.count {
            let columns = rows[i].components(separatedBy: ",")

            if columns.count >= 5 {
                let student = CertificateData(
                    fullName: columns[0],
                    className: columns[1],
                    achievement: columns[2],
                    eventName: columns[3],
                    teacherName: columns[4],
                    date: Date(),
                    signature: nil,
                    stamp: nil
                )
                result.append(student)
            }
        }

        print("✅ CSV → \(result.count) оқушы оқылды")
        return result
    }
}
