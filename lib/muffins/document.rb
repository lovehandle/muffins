module Muffins
  class Document

    include Virtus

    attribute :body, String, :reader => :protected

    # @api public
    def first(path)
      xml.at_css(path)
    end

    # @api public
    def all(path)
      xml.css(path)
    end

    # @api public
    def map(path, &block)
      all(path).map { |node| yield node }
    end

    # @api public
    def each(path, &block)
      all(path).each { |node| yield node }
    end

    private

    def xml
      @xml ||= Nokogiri::XML(body)
    end
  end
end
