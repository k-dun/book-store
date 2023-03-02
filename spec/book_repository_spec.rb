require 'book_repository'

def reset_books_table
  seed_sql = File.read('spec/seeds_books.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_books_table
  end

  context '#all' do
    it 'returns how many lines there is in the books table' do
      repo = BookRepository.new
      books = repo.all
      expect(books.length).to eq 3
    end

    it 'returns correct data' do
      repo = BookRepository.new
      books = repo.all
      expect(books[0].id).to eq "1"
      expect(books[0].title).to eq "1984"
      expect(books[0].author_name).to eq "George Orwell"
    end

    it 'returns correct data' do
      repo = BookRepository.new
      books = repo.all
      expect(books[1].id).to eq "2"
      expect(books[1].title).to eq "Game Of Thrones"
      expect(books[1].author_name).to eq "George RR Martin"
    end

    it 'returns correct data' do
      repo = BookRepository.new
      books = repo.all
      expect(books[2].id).to eq "3"
      expect(books[2].title).to eq "Girl With The Dragon Tattoo"
      expect(books[2].author_name).to eq "Stieg Larsson"
    end
  end
end