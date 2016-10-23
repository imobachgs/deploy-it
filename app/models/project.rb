# The `application` to deploy

class Project < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :kind, class_name: 'ProjectKind'
  belongs_to :user
  has_many :assignments
  has_many :machines, through: :assignments
  has_many :deployments
  accepts_nested_attributes_for :assignments, allow_destroy: true

  validates :name, :repo_url, :kind_id, :user_id, presence: true
  validate :check_repo_url, if: :repo_url?

  delegate :name, to: :kind, prefix: true

  def machine_with_role(role)
    assignments.where(role_id: role.id).first.try(:machine)
  end

  def available_roles
    self.class.roles
  end

  def available_adpaters
    self.class.adapters
  end

  def check_repo_url
    require 'net/http'

    if repo_url =~ URI::regexp
      url = URI.parse(repo_url)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = true if repo_url.split('/').first == "https:"
      res = req.request_head(url.path)
      errors.add(:repo_url, "this repository is not valid") if res.code != "200"
    else
      errors.add(:repo_url, "this url is not valid")
    end
  end
end
