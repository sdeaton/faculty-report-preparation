class Instructor < ActiveRecord::Base
  has_many :evaluations
end
