//
//  BookRowView.swift
//  BookShelf
//
//  Created by Jungjin Park on 2024-06-17.
//

import SwiftUI

struct BookRowView: View {
    var book: Book
    var body: some View {
        HStack(alignment: .top) {
            Image(book.mediumCoverImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 90)
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text("by \(book.author)")
                    .font(.subheadline)
                Text("\(book.pages) pages")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

#Preview {
    BookRowView(book: Book(title: "", author: "", isbn: "", pages: 0))
}
