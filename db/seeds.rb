# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def seed!(model, yaml)
  model.delete_all
  model.create! YAML.load(yaml)
end



seed! Skill, <<-YAML
- name: Ruby
  category: Language
  description: Fluency with Ruby
- name: Javascript/Coffeescript
  category: Language
  description: Fluency with Javascript/Coffeescript
- name: HTML/CSS
  category: Language
  description: Fluency with HTML/CSS
- name: SQL
  category: Language
  description: Fluency with SQL
- name: Git
  category: Tool
  description: Dexterity with Git
- name: Shell/Kernel
  category: Tool
  description: Dexterity with the Shell
- name: Text Editor
  category: Tool
  description: Dexterite with a Text Editor
- name: Rails
  category: Framework
  description: Knowledge of Rails
- name: jQuery/DOM
  category: Framework
  description: Knowledge of jQuery/DOM
- name: HTTP/TCP/IP
  category: Framework
  description: Knowledge of HTTP/TCP/IP
- name: Object-Oriented Programming
  category: Technique
  description: Mastery of Object-Oriented Programming techniques
- name: Testing
  category: Technique
  description: Mastery of Testing techniques
YAML



seed! User, <<-YAML
- name: Bob Lail
  email: bob.lail@cph.org
  password: password
  password_confirmation: password
- name: Luke Booth
  email: luke.booth@cph.org
  password: password
  password_confirmation: password
- name: Jesse Lewis
  email: jesse.lewis@cph.org
  password: password
  password_confirmation: password
- name: Gene Doyel
  email: gene.doyel@cph.org
  password: password
  password_confirmation: password
- name: Ordie Page
  email: ordie.page@cph.org
  password: password
  password_confirmation: password
- name: Kendall Park
  email: kendall.park@cph.org
  password: password
  password_confirmation: password
YAML



Assessment.delete_all
assessment = Assessment.create!



if Rails.env.development?
  Score.delete_all

  # Five users have completed the assessment
  scorers = User.limit(5).to_a

  User.find_each do |user|
    scorers.each do |scorer|
      next if scorer == user
      user.skills.each do |skill|
        scorer.score!(user, skill, rand(101), assessment)
      end
    end
  end
end
