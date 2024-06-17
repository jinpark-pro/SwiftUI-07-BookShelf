//
//  ContentView.swift
//  BookShelf
//
//  Created by Jungjin Park on 2024-06-17.
//

import SwiftUI

private class BooksViewModel: ObservableObject {
    @Published var books: [Book] = [Book]()
    @Published var fetching = false
    
    @MainActor
    func fetchData() async {
        fetching = true
        // set 2 seconds to delay
        do {
            try await Task.sleep(for: .seconds(2))
        } catch {
            
        }
        books = Book.sampleBooks
        fetching = false
    }
}

struct BookListView: View {
    @StateObject fileprivate var viewModel = BooksViewModel()
    
    var body: some View {
        List(viewModel.books) { book in
            BookRowView(book: book)
        }
        .overlay {
            if viewModel.fetching {
                ProgressView("Fetching data, please wait ...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .animation(.default, value: viewModel.books)
        .task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    BookListView()
}

//#Preview(traits: .sizeThatFitsLayout) {
//    ContentView(books: Book.sampleBooks)
//}
