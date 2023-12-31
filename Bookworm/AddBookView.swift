//
//  AddBookView.swift
//  Bookworm
//
//  Created by Khumbongmayum Tonny on 28/06/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var date = Date.now
    
    let genres = [
        "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"
    ]
    
    var body: some View {
        NavigationStack {
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

                    RatingView(rating: $rating)
                }
                
                Button("Save") {
                    let newBook = Book(context: moc)
                    newBook.id = UUID()
                    newBook.title = title
                    newBook.author = author
                    newBook.rating = Int16(rating)
                    newBook.genre = genre
                    newBook.review = review
                    newBook.date = date
                    
                    try? moc.save()
                    dismiss()
                }
                .disabled(hasValidDetails == false)
            }
            .navigationTitle("Add Book")
        }
    }
    
    var hasValidDetails: Bool {
        if title.trimmingCharacters(in: .whitespaces).isEmpty || author.trimmingCharacters(in: .whitespaces
        ).isEmpty {
            return false
        }
        return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
