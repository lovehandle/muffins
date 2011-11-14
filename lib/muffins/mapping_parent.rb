module Muffins
  class MappingParent

    include Virtus

    attribute :path,  String
    attribute :klass, Object

    # @api public
    def map(name, type, options = {})
      set_options(options).tap { |opts| klass.map(name, type, opts) }
    end

    private

    # @api private
    def set_options(options)
      options.tap do |opts|
        opts[:within] = [ path, opts[:within] ].compact.join(" > ")
      end
    end

  end
end