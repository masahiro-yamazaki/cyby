module Cyby
  module Kintone
    class Record
      def initialize(raw)
        @raw = raw
      end

      def [](key)
        if @raw.key?(key)
          convert(@raw[key])
        else
          fail "'#{key}' doesn't exist"
        end
      end

      def method_missing(method_name, *args)
        self.[](method_name.to_s.camelize(:lower))
      end

      def inspect
        hash = {}
        @raw.each do |key, value|
          hash[key] = value["value"]
        end
        hash.inspect
      end

      private
      def convert(args)
        type = args['type']
        value = args['value']
        case type
        when 'CALC'
          value.to_f
        when 'NUMBER'
          value.to_f
        when 'RECORD_NUMBER'
          value.to_i
        else
          value
        end
      end
    end
  end
end
