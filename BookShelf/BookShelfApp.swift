//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by Jungjin Park on 2024-06-17.
//

import SwiftUI

@main
struct BookShelfApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BookListView()
            }
        }
    }
}
