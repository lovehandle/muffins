require "spec_helper"

describe Muffins::MappingParent do

  class Book
    include Muffins
  end

  subject { Muffins::MappingParent.new(options) }

  let(:options) do
    { :path  => path,
      :klass => klass }
  end

  let(:klass) { Book    }
  let(:path)  { "#book" }

  let(:name) { :foo }
  let(:type) { String }
  let(:opts) { {} }

  its(:klass) { should eql(klass) }
  its(:path)  { should eql(path) }

  describe "#map" do
    it "initializes a namespaced mapping" do
      subject.map(name, type, opts)
      klass.send(:mappings).first.within.should == path
    end
  end

end