# The `application` to deploy

class Project < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :kind, class_name: 'ProjectKind'
  belongs_to :user
  has_many :assignments
  accepts_nested_attributes_for :assignments

  validates :name, :repo_url, :kind_id, :user_id, presence: true
end
