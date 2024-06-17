//
//  ContentView.swift
//  BookShelf
//
//  Created by Jungjin Park on 2024-06-17.
//

import SwiftUI

struct BookListView: View {
    var books: [Book] = Book.sampleBooks
    
    var body: some View {
        List(books, id: \.isbn) { book in
            BookRowView(book: book)
        }
        .listStyle(.plain)
    }
}

#Preview {
    BookListView()
}

//#Preview(traits: .sizeThatFitsLayout) {
//    ContentView(books: Book.sampleBooks)
//}
