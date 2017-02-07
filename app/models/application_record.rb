class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_accessor :serializer_detail
end
