class Text < ActiveRecord::Base
  has_many :replies, dependent: :destroy
end
