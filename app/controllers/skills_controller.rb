class SkillsController < ApplicationController
  before_action :authenticate_user, only: [:my_skills, :create]
  skip_after_action :verify_authorized

  def my_skills
    skills = current_user.profile.skills

    render json: skills.pluck(:name)
  end

  def index
    skills = Skill.all

    render json: skills.each_with_object({}) { |s, h| h[s.name] = {id: s.id} }
  end

  def create
    skill = Skill.find_or_create_by(name: params[:name].strip)
    
    render json: { id: skill.id, tag: skill.name }
  end
end
