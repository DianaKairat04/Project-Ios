import SwiftUI

struct HomeView: View {

    @Binding var isLoggedIn: Bool   // 🔥 Logout үшін керек

    var body: some View {
        NavigationStack {
            ZStack {
                Color("bg").ignoresSafeArea()

                VStack(spacing: 20) {

                    // HEADER
                    HStack {
                        VStack(alignment: .leading) {
                            Text("SchoolCert")
                                .font(DS.title(26))

                            Text("Мектеп сертификаттары")
                                .font(DS.body(14))
                                .foregroundColor(Color("muted"))
                        }

                        Spacer()

                        // 🔥 LOGOUT БАТЫРМАСЫ
                        Button {
                            isLoggedIn = false
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(Color("primary"))
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)

                    // GRID
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {

                        NavigationLink {
                            TemplateListView()
                        } label: {
                            HomeCard(title: "Сертификат",
                                     icon: "doc.text.image",
                                     color: Color.blue)
                        }

                        NavigationLink {
                            BatchGeneratorView()
                        } label: {
                            HomeCard(title: "Batch",
                                     icon: "tray.full.fill",
                                     color: Color.orange)
                        }

                        NavigationLink {
                            ArchiveView()
                        } label: {
                            HomeCard(title: "Архив",
                                     icon: "archivebox.fill",
                                     color: Color.purple)
                        }

                        NavigationLink {
                            ProfileView()
                        } label: {
                            HomeCard(title: "Мектеп",
                                     icon: "building.2.fill",
                                     color: Color.green)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView(isLoggedIn: .constant(true))
}
