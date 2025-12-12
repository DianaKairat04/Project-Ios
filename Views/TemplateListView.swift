import SwiftUI

struct TemplateListView: View {
    @EnvironmentObject var store: TemplateStore

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(store.templates) { template in
                    NavigationLink(
                        destination: CertificateEditorView(
                            viewModel: EditorViewModel(template: template)
                        )
                    ) {
                        VStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(template.accentColor.opacity(0.2))
                                .frame(height: 120)
                                .overlay(
                                    Image(systemName: "doc.richtext")
                                        .font(.system(size: 34))
                                        .foregroundColor(template.accentColor)
                                )

                            Text(template.name)
                                .font(DS.subtitle(14))
                        }
                        .padding(8)
                        .background(Color("card"))
                        .cornerRadius(14)
                        .shadow(radius: 4)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Шаблондар")
    }
}

