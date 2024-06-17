//
//  BookDetailView.swift
//  BookShelf
//
//  Created by Jungjin Park on 2024-06-17.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var book: Book
    @State var showEditBookView = false
    
    var body: some View {
        Form {
            Text(book.title)
            Image(book.largeCoverImageName)
                .resizable()
                .scaledToFit()
                .shadow(radius: 10)
                .padding()
            Label(book.author, systemImage: "person.crop.rectangle")
            Label("ISBN: \(book.isbn)", systemImage: "number")
            Label("\(book.pages) pages", systemImage: "book")
            // toggle 로 값을 바꾸지 않기 위해서 .constant 사용
            Toggle("Read", isOn: .constant(book.isRead))
            Button(action: { showEditBookView.toggle() }) {
                Label("Edit", systemImage: "pencil")
            }
        }
        .navigationTitle(book.title)
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: .constant(Book.sampleBooks[0]))
    }
}
