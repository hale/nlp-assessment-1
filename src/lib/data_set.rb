module EmotionClassifier
  class DataSet
    PATH = '../emotions'

    attr_reader :train
    attr_reader :dev
    attr_reader :test

    def initialize(sentiment)
      data = File.readlines(make_path(sentiment)).shuffle
      raise NoDataError.new(make_path(sentiment)) if data.empty?

      @train = data.first_percent(80)
      @dev = (data - @train).first_percent(10)
      @test = data - @train - @dev
    end

    private

    def make_path(filename)
      "#{PATH}/#{filename}.txt"
    end
  end

  class NoDataError < StandardError
    def initialize(filepath)
      super("#{filepath} contains no data")
    end
  end
end
