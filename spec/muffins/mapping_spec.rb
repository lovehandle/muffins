require 'spec_helper'

describe Muffins::Mapping do

  subject { described_class.new(options) }

  let(:name)       { :foo }
  let(:type)       { String }
  let(:to)         { ".book > .title" }
  let(:within)     { "#books" }
  let(:collection) { false }

  let(:document)   { fixture_file("books.html") }

  let(:options) do
    { :name       => name,
      :type       => type,
      :to         => to,
      :within     => within,
      :collection => collection }
  end

  its(:absolute_path) { should eql("#books > .book > .title") }
  its(:relative_path) { should eql(".book > .title") }

  describe "#parse" do
    context "when collection is false" do
      it { subject.parse(document).should eql("War and Peace (Vintage Classics)") }
    end

    context "when collection is true" do
      let(:collection) { true }
      it { subject.parse(document).should eql([ "War and Peace (Vintage Classics)", "Anna Karenina (Oprah's Book Club)" ])}
    end
  end

end