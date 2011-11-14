module Muffins
  class Document

    include Virtus

    attribute :body, Class, :reader => :protected

    # @api public
    def first(path)
      body.at_css(path)
    end

    # @api public
    def all(path)
      body.css(path)
    end

    # @api public
    def map(path, &block)
      all(path).map { |node| yield node }
    end

    # @api public
    def each(path, &block)
      all(path).each { |node| yield node }
    end

    protected

    # @api private
    def body=(body)
      case body
      when String
        @body = Nokogiri::XML(body)
      when Nokogiri::XML::Element
        @body = Nokogiri::XML(body.to_s)
      when Nokogiri::XML::Document
        @body = body
      else
        raise ArgumentError, "+body+ is an invalid type"
      end
    end

  end
end