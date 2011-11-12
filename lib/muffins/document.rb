module Muffins
  class Document

    include Virtus

    attribute :body, Class, :reader => :protected

    # @api public
    def first(path)
      node = body.at_css(path)
      node.text if node
    end

    # @api public
    def all(path)
      nodes = body.css(path)
      nodes.map(&:text)
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
      @body = Nokogiri::HTML(body)
    end

  end
end