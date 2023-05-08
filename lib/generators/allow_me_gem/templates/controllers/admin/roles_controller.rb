# frozen_string_literal: true

class Admin::RolesController < ApplicationController
  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_path, notice: 'Role was created.'
    else
      render :new
    end
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end