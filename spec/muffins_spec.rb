require 'spec_helper'

describe Muffins do

  class Book
    include Muffins

    path "Item"

    map :asin, String, :to => "ASIN"
    map :sales_rank, Integer, :to => "SalesRank"

    map :description, String, :to => "Content", :within => "EditorialReview"

    within "ItemAttributes" do |attributes|
      attributes.map :isbn, String, :to => "ISBN"
      attributes.map :release_date, Date, :to => "ReleaseDate"
    end

  end

  subject { Book }

  let(:book) { Book.new }

  let(:name)    { :foo   }
  let(:type)    { String }

  let(:mapping)  { mock(Muffins::Mapping) }
  let(:mappings) { [] }

  context "XML" do

    let(:document) { fixture_file("books.xml") }

    describe ".parse" do
      let(:books) { subject.parse(document) }
      let(:book)  { books.first }

      let(:book_asin) { "160942168X" }
      let(:book_sales_rank) { 693153 }

      let(:book_isbn) { "160942168X" }
      let(:book_release_date) { Date.parse("20011-09-01") }

      let(:book_description) do
        "This epic is considered one of the most celebrated works of"
      end

      it "initializes an instance for each document node matching the path" do
        books.size.should == 10
      end

      it "instantiates instances of the described class" do
        books.each { |book| book.should be_a(Book) }
      end

      it "parses each node and sets instance attributes from the mappings" do
        book.asin.should         eql(book_asin)
        book.sales_rank.should   eql(book_sales_rank)
        book.description.should  include(book_description)
        book.isbn.should         eql(book_isbn)
        book.release_date.should eql(book_release_date)
      end
    end

  end

  describe ".within" do
    it "yields an instance of MappingParent" do
      subject.within(name) do |parent|
        parent.should be_a(Muffins::MappingParent)
      end
    end
  end

  describe ".map" do

    before do
      Muffins::Mapping.stub(:new).and_return(mapping)
      subject.stub(:mappings).and_return(mappings)
    end

    it "initializes a new Mapping" do
      Muffins::Mapping.should_receive(:new).with(:name => name, :type => type)
      subject.map(name, type)
    end

    it "adds a mapping to the list of mappings" do
      mappings.should_receive(:<<).with(mapping)
      subject.map(name, type)
    end

    it "creates a getter method for :foo" do
      subject.map(name, type)
      book.should respond_to(name)
    end

    it "creates a setter method for :foo" do
      subject.map(name, type)
      book.should respond_to("#{name}=")
    end

  end

end