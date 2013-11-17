module EmotionClassifier
  class DataSet
    PATH = '../emotions'

    attr_reader :train
    attr_reader :dev
    attr_reader :test

    def initialize(sentiments)
      all_sentences = sentiments.each_with_object([]) do |sentiment, all|
        all << sentences(sentiment)
      end.flatten(1)

      @test = all_sentences.first_percent(10)
      @dev = (all_sentences - @test).first_percent(10)
      @train = (all_sentences - @dev - @test)
    end

    # don't expose the known-sentiment
    def test
      @test.map(&:first)
    end

    # don't expose the known-sentiment
    def dev
      @dev.map(&:first)
    end

    private

    def sentences(sentiment)
      filepath = make_path(sentiment)
      File.readlines(filepath).map { |sentence| [sentence, sentiment] }
    end

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
