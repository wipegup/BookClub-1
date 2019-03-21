require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
  end

  describe 'Relationships' do
    it { should have_many :book_authors}
    it { should have_many(:books).through :book_authors }
  end

  describe 'Class Methods' do
    it '.authors_from_string creates list of authors' do
      author_string_1 = "Dan Brown"
      author_string_2 = "Dan Brown, corey sheesley"

      author_list_1 = Author.authors_from_string(author_string_1)
      author_list_2 = Author.authors_from_string(author_string_2)

      expect(author_list_1[0].name).to eq(author_string_1)
      expect(author_list_1.length).to eq(1)

      expect(author_list_1[0].name).to eq("Dan Brown")
      expect(author_list_1[1].name).to eq("Corey Sheesley")
      expect(author_list_1.length).to eq(2)
    end
  end
end
