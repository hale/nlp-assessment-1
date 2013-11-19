module EmotionClassifier
  class Classifier
    attr_reader :sentiments
    attr_reader :data
    attr_reader :individual_word_counts
    attr_reader :sentiment_word_counts

    def initialize(sentiments: sentiments)
      @sentiments = sentiments
      @data = DataSet.new(sentiments)
    end


    def classify(sentence: sentence)
      train
      Emotion.new(:angry)
    end

    def train
       @data.use_set(:train)

      all_words = @data.set.map(&:first).flatten(1).map(&:split).flatten(1)
      @individual_word_counts = all_words.uniq.each_with_object({}) do |word, wc|
        wc[word] = all_words.count(word)
      end

      @sentiment_word_counts = @sentiments.each_with_object({}) do |sentiment, wc|
        wc[sentiment] =
          @data.with_sentiment(sentiment).map(&:first).map(&:split).count
      end
      @sentiment_word_counts[:all] = @sentiment_word_counts.values.reduce(0, :+)

      @trained = true
    end

    def probability(word: word, sentiment: :all)
      if sentiment == :all
        @individual_word_counts[word] / @sentiment_word_counts[:all]
      else
        @data.with_sentiment(sentiment).map(&:first).count(word) /
          @sentiment_word_counts[sentiment]
      end
    end

    def trained?
      @trained
    end
  end
end

