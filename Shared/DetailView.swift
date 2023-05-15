//
//  DetailView.swift
//  bookworm
//
//  Created by Daniel Lucena Pires on 15/05/23.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .offset(x: -5, y: -5)
            }
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .alert("Deletar livro", isPresented: $showingDeleteAlert) {
            Button("Deletar", role: .destructive, action: deleteBook)
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Tem certeza?")
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Deletar este livro", systemImage: "trash")
            }
        }
    }
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}
