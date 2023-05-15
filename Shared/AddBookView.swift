//
//  AddBookView.swift
//  bookworm
//
//  Created by Daniel Lucena Pires on 15/05/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var review = ""
    @State private var rating = 3
    @State private var genre = ""
    
    let genres = ["Fantasia", "Terror", "Crianças", "Mistério", "Poesia", "Romance", "Suspense"]
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Nome do livro", text: $title)
                    TextField("Nome do autor", text: $author)
                    
                    Picker("Gênero", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text(String($0))
                        }
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)

                } header: {
                    Text("Escreva uma resenha")
                }
                
                Section {
                    Button("Salvar") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review

                        try? moc.save()
                        dismiss()
                    }
                }
            }.navigationTitle("Adicionar livro")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
