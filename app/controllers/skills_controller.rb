class SkillsController < ApplicationController
  before_action :authenticate_user, only: :index
  skip_after_action :verify_authorized

  def index
    @skills = current_user.profile.skills
    
    render json: @skills.map { |s| { tag: s.name } }
  end

  def available_skills
    @skills = Skill.all
    
    render json: @skills.each_with_object({}) { |s, h| h[s.name] = {id: s.id} }
  end
end
