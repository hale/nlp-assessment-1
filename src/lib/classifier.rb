module EmotionClassifier
  require 'bigdecimal'

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
      probs = sentiments.each_with_object({}) do |sentiment, p|
        p[sentiment] = @data.word_count(sentiment: sentiment) / @data.word_count
        sentence.downcase.split.each do |word|
          prob = probability(word: word, sentiment: sentiment)
          p[sentiment] *= prob if prob > 0
        end
      end
      Emotion.new(probs.max_by { |sentiment, _| sentiment }.first )
    end

    def sentiment_word_count(sentiment)
      @data.words(sentiment: sentiment).count
    end

    def probability(word: word, sentiment: :all)
      @data.word_count(word: word) / @data.word_count(sentiment: sentiment)
    end
  end
end

