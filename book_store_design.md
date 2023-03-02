Books Model and Repository Classes Design Recipe

1. Design and create the Table

Table: books

Columns:
id | title | author_name
2. Create Test SQL seeds

TRUNCATE TABLE books RESTART IDENTITY;

INSERT INTO books (title, author_name) VALUES ('1984', 'George Orwell');
INSERT INTO books (title, author_name) VALUES ('Game Of Thrones', 'George RR Martin');
INSERT INTO books (title, author_name) VALUES ('Girl With The Dragon Tattoo', 'Stieg Larsson');

psql -h 127.0.0.1 book_store_test < seeds_books.sql

3. Define the class names

# Table name: books

# Model class
# (in lib/book.rb)
class Book
end

# Repository class
# (in lib/book_repository.rb)
class BookRepository
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# Table name: books

# Model class
# (in lib/book.rb)

class Book
  attr_accessor :id, :title, :author_name
end

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# Table name: bookss

# Repository class
# (in lib/books_repository.rb)

class BookRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, author_name FROM books;
    # Returns an array of Book objects.
  end
end
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all books

repo = BookRepository.new

books = repo.all

books.length # =>  3

books[0].id # =>  1
books[0].title # =>  '1984'
books[0].author_name # =>  'George Orwell'

books[1].id # =>  2
books[1].title # =>  'Game Of Thrones'
books[1].author_name # =>  'George RR Martin'

books[2].id # =>  3
books[2].title # =>  'Girl With The Dragon Tattoo'
books[2].author_name # =>  'Stieg Larsson'

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end