import SwiftUI

struct ArchiveView: View {
    @State private var files: [URL] = []

    var body: some View {
        List {
            ForEach(files, id: \.self) { file in
                HStack {
                    Image(systemName: "doc.richtext.fill")
                        .foregroundColor(.blue)

                    Text(file.lastPathComponent)
                        .font(.body)

                    Spacer()

                    Button {
                        share(url: file)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .onDelete(perform: deleteFiles)
        }
        .onAppear(perform: loadFiles)
        .navigationTitle("Архив")
    }

    func loadFiles() {
        let dir = FileManager.default.temporaryDirectory
        let all = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
        files = all?.filter { $0.pathExtension == "pdf" } ?? []
    }

    func deleteFiles(at offsets: IndexSet) {
        offsets.forEach { i in
            try? FileManager.default.removeItem(at: files[i])
        }
        loadFiles()
    }

    func share(url: URL) {
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true)
    }
}

