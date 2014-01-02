# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'active_record/fixtures'

def seed!(model, yaml)
  model.delete_all
  model.create! YAML.load(yaml)
end

def load_fixtures!(path)
  table_name = File.basename(path, ".yml")
  model = table_name.classify.constantize
  ids = []
  YAML.load_file(path).each do |slug, attributes|
    id = ActiveRecord::Fixtures.identify(slug)
    record = model.find_by_id(id) || model.new
    record.attributes = attributes.merge(id: id)
    record.save!
    ids << id
  end
  model.where(model.arel_table[:id].not_in(ids)).delete_all
end



load_fixtures! Rails.root.join("db", "skills.yml")



seed! User, <<-YAML
- first_name: Bob
  last_name: Lail
  email: bob.lail@cph.org
  password: password
  password_confirmation: password
- first_name: Luke
  last_name: Booth
  email: luke.booth@cph.org
  password: password
  password_confirmation: password
- first_name: Jesse
  last_name: Lewis
  email: jesse.lewis@cph.org
  password: password
  password_confirmation: password
- first_name: Gene
  last_name: Doyel
  email: gene.doyel@cph.org
  password: password
  password_confirmation: password
- first_name: Ordie
  last_name: Page
  email: ordie.page@cph.org
  password: password
  password_confirmation: password
- first_name: Kendall
  last_name: Park
  email: kendall.park@cph.org
  password: password
  password_confirmation: password
YAML



Assessment.delete_all
assessment = Assessment.create!(assessors: User.all)



if Rails.env.development?
  Score.delete_all

  # # Five users have completed the assessment
  # scorers = User.limit(5).to_a
  # 
  # User.find_each do |user|
  #   scorers.each do |scorer|
  #     next if scorer == user
  #     user.skills.each do |skill|
  #       scorer.score!(user, skill, rand(101), assessment)
  #     end
  #   end
  # end
end
