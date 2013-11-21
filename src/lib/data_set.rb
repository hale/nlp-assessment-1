require 'memoist'

module EmotionClassifier
  class DataSet
    extend Memoist

    PATH = '../emotions'

    attr_reader :train
    attr_reader :set
    attr_reader :ngram_order
    attr_reader :dev

    def initialize(sentiments)
      @all = sentiments.each_with_object([]) do |sentiment, all|
        all << sentences(sentiment)
      end.flatten(1)

      @test = @all.first_percent(10)
      @dev = (@all - @test).first_percent(10)
      @train = (@all - @dev - @test)

      use_set(:all)
      set_ngram_order(1)
    end

    def set_ngram_order(order)
      @ngram_order = order
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
    memoize :with_sentiment

    def words(sentiment: :all)
      words = if sentiment == :all
        @set.map(&:first).flatten(1).map(&:split).flatten(1)
      else
        with_sentiment(sentiment).map(&:first).map(&:split).flatten
      end
      if @ngram_order == 1
        words
      else
        Ngram.new(words).ngrams(@ngram_order)
      end
    end

    def word_count(word: nil, sentiment: :all)
      if word
        words(sentiment: sentiment).count(word)
      else
        words(sentiment: sentiment).count
      end.to_f
    end

    private

    def sentences(sentiment)
      filepath = make_path(sentiment)
      File.readlines(filepath)
        .map { |word| word.downcase.gsub(/[^[[:word:]]\s]/, '') }
        .map { |sentence| [sentence, sentiment] }
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
