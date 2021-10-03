# frozen_string_literal: true

module Parsers
  class TranslatorParser
    def self.call(*args)
      new(*args).call
    end

    def initialize(link)
      @link = link
    end

    def call
      {
        first_name: first_name,
        last_name: last_name,
        country: country,
        native_language: native_language,
        target_language: target_language,
        source: link
      }
    end

    private

    attr_accessor :link

    def name
      @name ||= doc.xpath('/html/body/table/tr/td/div/div/table/tr/td/div/div/table/tr/td/table/tr/td[2]/'\
                          'table[1]/tr[1]/td[1]/font/strong')
                   .first
                   .content
                   .squish
    end

    def first_name
      name.split.first.squish
    end

    def last_name
      name.split[1..].join(' ').squish
    end

    def country
      doc.xpath('/html/body/table/tr/td/div/div/table/tr/td/div/div/table/tr/td/table/tr/td[2]'\
                '/table[1]/tr[1]/td[1]/div[1]/text()')
         .first
         .text
         .squish
         .split(', ')
         .last
    end

    def native_language
      doc.xpath('/html/body/table/tr/td/div/div/table/tr/td/div/div/table/tr/td/table/tr/td[2]'\
                '/table[1]/tr[1]/td[1]/div[2]/text()')
         .map do |el|
        el.text.squish
      end
         .reject(&:blank?)
         .first
         .to_s
         .sub(/\A:/, '')
         .squish
    end

    def target_language
      (pairs - working_languages).concat(working_languages).uniq.join(', ')
    end

    def working_languages
      @working_languages ||= doc.css('#lang_full span > span')
                                .map { |el| el.text.squish }
                                .map { |el| el.sub(/ to \w*\z/, '') }
                                .uniq
    end

    def pairs
      @pairs ||= doc.css('#about_me tr td.pageText table tr td.pageText table tr')
                    .map { |el| el.css('td:first-child font') }
                    .map { |el| el.text.squish }
                    .select { |text| /\A\w+ to \w+\z/.match(text) }
                    .map { |el| el.sub(/ to \w*\z/, '') }
                    .uniq
    end

    def fetched_body
      @fetched_body ||= Excon.get(link).body
    end

    def doc
      @doc ||= Nokogiri::HTML(fetched_body)
    end
  end
end
