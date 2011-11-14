require 'spec_helper'

describe Muffins::Document do

  subject { described_class.new(:body => body) }

  context "HTML" do

    let(:body) { fixture_file("books.html") }
    let(:path) { ".book" }

    describe "#all" do
      it "returns 2 objects" do
        subject.all(path).size.should eql(2)
      end
    end

    describe "#first" do
      it "returns a string" do
        subject.first(path).should be_a(Nokogiri::XML::Element)
      end
    end

  end

  context "XML" do

    let(:body) { fixture_file("books.xml") }
    let(:path) { "Item" }

    describe "#all" do
      it "returns 10 objects" do
        subject.all(path).size.should eql(10)
      end
    end

    describe "#first" do
      it "returns an element" do
        subject.first(path).should be_a(Nokogiri::XML::Element)
      end
    end

  end


end