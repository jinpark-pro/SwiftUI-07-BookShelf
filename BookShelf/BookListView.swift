//
//  ContentView.swift
//  BookShelf
//
//  Created by Jungjin Park on 2024-06-17.
//

import SwiftUI
import Combine

private extension String {
    func matches(_ searchTerm: String) -> Bool {
        self.range(of: searchTerm, options: .caseInsensitive) != nil
    }
}
private class BooksViewModel: ObservableObject {
    @Published var books: [Book] = [Book]()
    @Published var fetching = false
    @Published var searchTerm: String = ""
    
    @Published var filteredBooks: [Book] = [Book]()

    init() {
        Publishers.CombineLatest($books, $searchTerm).map { books, searchTerm in
            books.filter { book in
                searchTerm.isEmpty ? true : (book.title.matches(searchTerm) || book.author.matches(searchTerm))
            }
        }
        .assign(to: &$filteredBooks)
    }
    @MainActor
    func fetchData() async {
        fetching = true
        books.removeAll()
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
        List(viewModel.filteredBooks) { book in
            BookRowView(book: book)
        }
        .searchable(text: $viewModel.searchTerm)
        .autocapitalization(.none)
        .refreshable {
            await viewModel.fetchData()
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
    NavigationStack {
        BookListView()
    }
}

//#Preview(traits: .sizeThatFitsLayout) {
//    ContentView(books: Book.sampleBooks)
//}
