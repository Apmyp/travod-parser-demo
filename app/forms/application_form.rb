# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Validations

  def persisted?
    false
  end
end
