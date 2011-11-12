module Muffins
  class MappingParent

    include Virtus

    attribute :path,  String
    attribute :klass, Object

    # @api public
    def map(name, type, options = {})
      set_options(options).tap do |options|
        klass.map(name, type, options)
      end

      self
    end

    private

    # @api private
    def set_options(options)
      options[:within] = [ path, options[:within] ].compact.join(" > ")
      options
    end

  end
end