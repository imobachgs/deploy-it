FactoryGirl.define do
  factory :project do
    user
    name 'A Rails project'
    repo_url 'http://example.com'
    desc 'The project description'

    association :kind, factory: :project_kind
  end
end
