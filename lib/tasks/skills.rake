require 'active_record/fixtures'

namespace :db do
  namespace :load do
    
    desc "Repopulate skills and their metadata"
    task :skills => [:environment] do
      path = Rails.root.join("db", "skills.yml")
      ids = []
      YAML.load_file(path).each do |slug, attributes|
        id = ActiveRecord::Fixtures.identify(slug)
        record = Skill.find_by_id(id) || Skill.new
        record.attributes = attributes.merge(id: id)
        record.save!
        ids << id
      end
      Skill.where(Skill.arel_table[:id].not_in(ids)).delete_all
    end
    
  end
end
