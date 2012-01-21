require 'active_support/core_ext/string'

class MigrateEverything < ActiveRecord::Migration
  def change
    GitHub::Resources.constants.each do |resource|
      klass = GitHub::Resources.const_get(resource)
      create_table resource.to_s.pluralize.downcase do |table|
        klass.class_variable_get(:@@attributes).each_pair do |key, value|
          table.send(value, key)
        end
      end
    end
  end
end
