require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :pages}
    it { should validate_presence_of :year}
    it { should validate_presence_of :cover}
  end

  describe 'Relationships' do
    it { should have_many :book_authors }
    it { should have_many(:authors).through :book_authors }
    it { should have_many :reviews }
  end

  describe 'Instance Method' do
    it "new .author_names method; returns a list of strings(names)" do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      expect(book_1.author_names).to eq(["J.R.R Tolkein"])
      expect(book_2.author_names).to eq(["William Peterson", "Corey Sheesley"])
    end

    it "it can get a list of co-author names" do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 400, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      expect(book_1.co_authors(author_1)).to eq([])
      expect(book_2.co_authors(author_2)).to eq(["Corey Sheesley"])
    end
  end

  describe 'Class Method' do
    it "can sort books by number of pages" do
      author_1 = Author.create(name: "J.R.R Tolkein")
      author_2 = Author.create(name: "William Peterson")
      author_3 = Author.create(name: "Corey Sheesley")

      book_1 = author_1.books.create(title: "The Hobbit", pages: 300, year: 1999, cover: "madeupurl.com")
      book_2 = author_2.books.create(title: "Title_2", pages: 450, year: 1998, cover: "othermadeupurl.com")
      book_2.authors << author_3
      book_3 = author_2.books.create(title: "Art of Data", pages: 400, year: 2000, cover: "otherothermadeupurl.com")

      ascending_pages = Book.sort_pages(:asc)
      decending_pages = Book.sort_pages(:desc)

      expect(ascending_pages).to eq([book_1, book_3, book_2])
      expect(decending_pages).to eq([book_2, book_3, book_1])
    end
  end
end
