//
//  AddBookView.swift
//  Bookworm
//
//  Created by Khumbongmayum Tonny on 28/06/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = [
        "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"
    ]
    
    var body: some View {
        Form {
            Section {
                TextField("Name of book", text: $title)
                TextField("Author's name", text: $author)
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) { genre in
                        Text(genre)
                    }
                }
            }
            
            Section("Write a review") {
                TextField("", text: $review)
                
                Picker("Rating", selection: $rating) {
                    ForEach(0..<6) {
                        Text(String($0))
                    }
                }
            }
            
            Button("Save") {
                // add the book
                let newBook = Book(context: moc)
                newBook.id = UUID()
                newBook.title = title
                newBook.author = author
                newBook.rating = Int16(rating)
                newBook.genre = genre
                newBook.review = review
                
                try? moc.save
            }
        }
        .navigationTitle("Add Book")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddBookView()
        }
    }
}
