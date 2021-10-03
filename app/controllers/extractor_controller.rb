# frozen_string_literal: true

class ExtractorController < ApplicationController
  def index
    @form = NewLinkForm.new
  end

  def create
    @form = NewLinkForm.new(form_params)
    @form.validate!
  rescue ActiveModel::ValidationError
    render 'index', form: @form
  end

  private

  def form_params
    params.require(:new_link_form).permit(:link)
  end
end
