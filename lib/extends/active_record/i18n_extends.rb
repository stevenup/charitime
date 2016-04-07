# -*- encoding : utf-8 -*-
module Extends::ActiveRecord::I18nExtends
  extend ActiveSupport::Concern

  module ClassMethods
    # Alias the human_attribute_name method for getting translation on attributes, it's too loooong
    def hn(attribute, options = {})
      self.human_attribute_name attribute, options
    end
  end
end

ActiveRecord::Base.send(:include, Extends::ActiveRecord::I18nExtends)
