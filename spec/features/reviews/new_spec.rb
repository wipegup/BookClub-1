require 'rails_helper'

RSpec.describe 'new review workflow', type: :feature do
  context 'as a user visiting a books show page' do
    it 'shows a link to add a new review for the book' do
      author_1 = Author.create(name: "J.R.R Tolkein")
      book_1 = author_1.books.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")

      visit book_path(book_1)

      click_link 'New Review'

      expect(current_path).to eq(new_book_review_path(book_1))

      expect(page).to have_content("Title")
      expect(page).to have_content("User")
      expect(page).to have_content("Rating")
      expect(page).to have_content("Text")
    end
  end

  # context 'as a user filling out a new review form' do
  #   xit 'should accept input for a new review of a book, including title, user, rating, text' do
  #     book_1 = Book.create(title: "The Hobbit", pages: 200, year: 1999, cover: "madeupurl.com")
  #
  #     # visit
  #
  #     review_title = "Best Ever"
  #     review_user = "User_1"
  #     review_rating = 5
  #     review_text = "Here is a long description of the review for the book"
  #   end
  # end
end
