module Muffins
  class Mapping

    include Virtus

    attribute :name,       Symbol
    attribute :to,         String
    attribute :within,     String
    attribute :collection, Boolean

    # @api public
    def parse(doc)
      document = Muffins::Document.new(:body => doc.to_s)

      if collection?
        document.map(absolute_path) { |node| node.text }
      else
        node = document.first(absolute_path)
        node.text if node
      end
    end

    # @api public
    def absolute_path
      within ? [ within, relative_path ].compact.join(" > ") : relative_path
    end

    # @api public
    def relative_path
      to || name
    end

  end
end
