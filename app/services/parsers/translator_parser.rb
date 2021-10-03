module Parsers
    class TranslatorParser
        def self.call
            Excon.get('https://www.proz.com/profile/52171').body
        end
    end
end
