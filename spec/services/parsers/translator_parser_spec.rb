# frozen_string_literal: true

describe Parsers::TranslatorParser do
  context 'with profile link' do
    let(:test_link) { 'https://www.proz.com/profile/52171' }
    let(:profile_hash) do
      {
        first_name: 'Antonella',
        last_name: 'Vallicelli',
        country: 'Italy',
        native_language: 'Italian',
        target_language: 'English, German',
        source: test_link
      }
    end

    context 'when all is OK' do
      it 'returns profile hash' do
        VCR.use_cassette("#{described_class}_#{test_link}".parameterize) do
          expect(described_class.call(test_link)).to include(profile_hash)
        end
      end
    end
  end

  context 'with translator link' do
    let(:test_link) { 'https://www.proz.com/translator/88393' }
    let(:profile_hash) do
      {
        first_name: 'Mariette',
        last_name: 'van Heteren',
        country: 'Netherlands',
        native_language: 'Dutch',
        target_language: 'Turkish, German, French, English',
        source: test_link
      }
    end

    context 'when all is OK' do
      it 'returns profile hash' do
        VCR.use_cassette("#{described_class}_#{test_link}".parameterize) do
          expect(described_class.call(test_link)).to include(profile_hash)
        end
      end
    end
  end
end
