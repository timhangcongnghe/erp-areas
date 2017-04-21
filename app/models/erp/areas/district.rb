module Erp::Areas
  class District < ApplicationRecord
    belongs_to :state
  end
end
