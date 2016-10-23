class Assignment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :project
  belongs_to :machine
end
