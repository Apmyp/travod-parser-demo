# frozen_string_literal: true

describe Parsers::TranslatorParser do
  it 'test example' do
    VCR.use_cassette(described_class.to_s) do
      puts described_class.call
    end
  end
end
