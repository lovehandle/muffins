require 'nokogiri'
require 'virtus'

module Muffins

  # @api private
  def self.included(base)
    base.send(:include, Virtus)
    base.extend(Virtus::Options)
    base.accept_options(:path)
    base.extend(ClassMethods)
  end

  private_class_method :included

end

require "muffins/version"
require "muffins/class_methods"
require "muffins/mapping"
require "muffins/mapping_parent"
require "muffins/document"
