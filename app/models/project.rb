# The `application` to deploy

class Project < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :kind, class_name: 'ProjectKind'
  belongs_to :user

  has_many :assignments
  has_many :deployments
  has_many :machines, through: :assignments
  has_many :deployments, -> { order(created_at: :desc) }

  accepts_nested_attributes_for :assignments, allow_destroy: true

  validates :name, :repo_url, :kind_id, :user_id, presence: true
  validate :check_repo_url, if: :repo_url?

  delegate :name, to: :kind, prefix: true

  def deploying?
    deployments.last.try(:unfinished?)
  end

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

# == Schema Information
#
# Table name: projects
#
#  id                :integer          not null, primary key
#  name              :string
#  repo_url          :string
#  desc              :text
#  kind_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  ruby_version      :string           default("2")
#  database_adapter  :string           default("postgresql")
#  database_name     :string           default("rails")
#  database_username :string           default("rails")
#  database_password :string           default("rails")
#  secret            :string           default("")
#  type              :string           default("RailsProject"), not null
#  port              :integer          default(80)
#  db_admin_password :string           default("")
#
