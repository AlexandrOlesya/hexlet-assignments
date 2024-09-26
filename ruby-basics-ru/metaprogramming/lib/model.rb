# frozen_string_literal: true

require 'date'

module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attributes
      @attributes ||= {}
    end

    def attribute(name, options = {})
      attributes[name] = options[:type]

      define_method(name) do
        value = instance_variable_get("@#{name}")
        type = self.class.attributes[name]

        if value.nil?
          nil
        elsif type
          convert_to_type(value, type)
        else
          value
        end
      end

      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) if self.class.attributes.key?(name)
    end
  end

  def attributes
    self.class.attributes.keys.each_with_object({}) do |name, result|
      result[name] = send(name)
    end
  end

  private

  def convert_to_type(value, type)
    case type
    when :integer
      value.to_i
    when :float
      value.to_f
    when :string
      value.to_s
    when :datetime
      DateTime.parse(value.to_s) rescue nil
    when :boolean
      !!value
    else
      value
    end
  end
end
