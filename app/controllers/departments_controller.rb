class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show ]

  def show
    @hod = User.where("department_id = ? AND role_id = 3", @department.id).last
    @faculties = User.where("department_id = ? AND role_id = 2", @department.id)
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end
end
