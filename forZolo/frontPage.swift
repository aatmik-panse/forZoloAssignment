import SwiftUI

// Front view of the app
struct ContentView_Front: View {
    @ObservedObject var viewModel = BookViewModel() // ViewModel for managing book data
    @State private var isAddBookPresented = false // State variable to manage AddBookView presentation

    var body: some View {
        // A navigation stack wrapping the whole content
        NavigationStack {
            VStack {
                ZStack {
                    List {
                        // Displaying each book detail from the ViewModel
                        ForEach(viewModel.bookDetails) { item in
                            NavigationLink(destination: ContentView()) { // Navigating to ContentView when an item is tapped
                                HStack {
                                    Image(item.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(15.0)
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        
                                        Text("by \(item.by)")
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                    // Display genres
                                    VStack{
                                        Text("Genres:")
                                            .font(.callout)
                                        
                                        Text(item.genre.joined(separator: ", "))
                                            .font(.callout)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }.listRowSeparator(.hidden)
                    }.listStyle(.insetGrouped)
                    .listRowBackground(Color.clear)
                    .listRowSpacing(10)
                }
                .cornerRadius(15)
                Spacer()
                Button(action: {
                    isAddBookPresented.toggle()
                }) {
                }
                .sheet(isPresented: $isAddBookPresented) {
                    AddBookView(viewModel: viewModel)
                }
                TopNavBar(isAddBookPresented: $isAddBookPresented)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 10)
                Spacer()
            }
            .navigationTitle("Book Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddBookPresented.toggle()
                    }) {
                    }
                }
            }
        }
    }
}

// Preview provider for ContentView_Front
struct ContentView_Front_Preview: PreviewProvider {
    static var previews: some View {
        ContentView_Front()
    }
}
