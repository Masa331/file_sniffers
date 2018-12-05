module FileSniffers
  # https://stackoverflow.com/questions/14693929/ruby-how-can-i-detect-intelligently-guess-the-delimiter-used-in-a-csv-file
  class ColSepSniffer
    NoColumnSeparatorFound = Class.new(StandardError)
    EmptyFile = Class.new(StandardError)

    COMMON_DELIMITERS = [
      '","',
      '"|"',
      '";"'
    ].freeze

    def initialize(first)
      @first = first
    end

    def self.call(first)
      new(first).find
    end

    def find
      fail EmptyFile unless first

      if valid?
        delimiters[0][0][1]
      else
        fail NoColumnSeparatorFound
      end
    end

    private

    def valid?
      !delimiters.collect(&:last).reduce(:+).zero?
    end

    # delimiters #=> [["\"|\"", 54], ["\",\"", 0], ["\";\"", 0]]
    # delimiters[0] #=> ["\";\"", 54]
    # delimiters[0][0] #=> "\",\""
    # delimiters[0][0][1] #=> ";"
    def delimiters
      @delimiters ||= COMMON_DELIMITERS.inject({}, &count).sort(&most_found)
    end

    def most_found
      ->(a, b) { b[1] <=> a[1] }
    end

    def count
      ->(hash, delimiter) { hash[delimiter] = first.count(delimiter); hash }
    end

    def first
      @first
    end
  end
end
