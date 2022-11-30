class MembersController < ApplicationController
  before_action :set_member, only: %i[ show ]

  def show
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end
end
