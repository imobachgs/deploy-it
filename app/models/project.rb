# The `application` to deploy

class Project < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :kind, class_name: 'ProjectKind'

  validates :name, :repo_url, :kind_id, presence: true
end
