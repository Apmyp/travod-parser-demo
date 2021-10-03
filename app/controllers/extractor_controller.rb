# frozen_string_literal: true

class ExtractorController < ApplicationController
  def new
    @form = NewLinkForm.new
  end

  def create
    @form = NewLinkForm.new(form_params)
    @form.validate!

    extracted_hash = Parsers::TranslatorParser.call(@form.link)
    @linguist = Linguist.new(extracted_hash)
  rescue ActiveModel::ValidationError
    render 'new', form: @form
  end

  def create_linguist
    @linguist = Linguist.new(linguist_params)
    @linguist.save!

    redirect_to extractor_path(@linguist.id)
  rescue ActiveRecord::RecordInvalid
    render 'create', linguist: @linguist
  end

  def show
    @linguist = Linguist.find(params[:id])
  end

  private

  def form_params
    params.require(:new_link_form).permit(:link)
  end

  def linguist_params
    params.require(:linguist).permit(:first_name, :last_name, :country, :language, :native_language, :target_language,
                                     :source)
  end
end
