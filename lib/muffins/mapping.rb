module Muffins
  class Mapping

    include Virtus

    attribute :name,       Symbol
    attribute :type,       Class
    attribute :to,         String
    attribute :within,     String
    attribute :collection, Boolean

    # @api public
    def parse(doc)
      document = Muffins::Document.new(:body => doc)

      if collection?
        document.map(absolute_path) { |node| coerce(node.text) }
      else
        coerce(document.first(absolute_path).text)
      end
    end

    # @api public
    def coerce(value)
      Virtus::Coercion[value.class].send(coercion_method, value)
    end

    # @api public
    def coercion_method
      Virtus::Attribute.determine_type(type).coercion_method
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