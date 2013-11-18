module EmotionClassifier
  class DataSet
    PATH = '../emotions'

    attr_reader :train
    attr_reader :set

    def initialize(sentiments)
      @all = sentiments.each_with_object([]) do |sentiment, all|
        all << sentences(sentiment)
      end.flatten(1)

      @test = @all.first_percent(10)
      @dev = (@all - @test).first_percent(10)
      @train = (@all - @dev - @test)

      use_set(:all)
    end

    def use_set(set)
      @set = case set
             when :all then @all
             when :test then @test
             when :dev then @dev
             when :train then @train
             else raise StandardError.new("Invalid dataset name")
             end
    end

    def with_sentiment(sentiment)
      @set.select { |_, sentence_sentiment| sentence_sentiment == sentiment }
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
