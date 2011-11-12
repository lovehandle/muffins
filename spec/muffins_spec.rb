require 'spec_helper'

describe Muffins do

  class Book
    include Muffins

    path ".book"
  end

  subject { Book }

  let(:book) { Book.new }

  let(:name)    { :foo   }
  let(:type)    { String }

  let(:mapping)  { mock(Muffins::Mapping) }
  let(:mappings) { [] }

  describe ".parse" do

    let(:document) { fixture_file("books.html") }

    it "parses a document based on the path" do
      subject.parse(document).count.should == 2
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