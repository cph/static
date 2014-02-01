class ManagerReview < ActiveRecord::Base
  class Section < Struct.new(:predicate, :questions)
  end
end
