# frozen_string_literal: true

class NewLinkForm < ApplicationForm
  attr_accessor :link

  validates_presence_of :link
  validate :known_link_format

  def known_link_format
    return if link.blank?
    return if %r{\Ahttps://www.proz.com/(translator|profile)/\d+\z}.match(link)

    errors.add(:link, 'Unknown link for extraction. Please double-check the link')
  end
end
