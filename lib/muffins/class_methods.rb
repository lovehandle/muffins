module Muffins
  module ClassMethods

    # @api public
    def map(name, type, options = {})
      options[:name] = name
      options[:type] = type

      mapping = Mapping.new(options)

      add_mapping(mapping)
      add_attribute(name, type)

      self
    end

    # @api public
    def within(path, &block)
      Muffins::MappingParent.new(:path => path, :klass => self).tap { |parent| yield parent }
    end

    # @api public
    def parse(doc, options = {})
      document = Muffins::Document.new(:body => doc)

      if options[:single]
        new_from_node(document.first(path))
      else
        document.map(path) { |node| new_from_node(node) }
      end
    end

    private

    # @api private
    def mappings
      @mappins ||= []
    end

    # @api private
    def add_mapping(mapping)
      mappings << mapping
    end

    # @api private
    def add_attribute(name, type)
      attribute(name, type)
    end

    # @api private
    def new_from_node(node)
      new.tap do |obj|
        mappings.each do |mapping|
          obj.send("#{mapping.name}=", mapping.parse(node))
        end
      end
    end

  end
end