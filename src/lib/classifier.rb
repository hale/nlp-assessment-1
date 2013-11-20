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
      train
      probs = sentiments.each_with_object({}) do |sentiment, p|
        p[sentiment] = data.words(sentiment: sentiment).count.to_f / @data.words.count.to_f
        sentence.downcase.split.each do |word|
          prob = probability(word: word, sentiment: sentiment)
          p[sentiment] *= prob if prob > 0
        end
      end
      Emotion.new(probs.max_by { |sentiment, _| sentiment }.first )
    end

    def train
      @data.use_set(:train)

      @individual_word_counts = @data.words.uniq.each_with_object({}) do |word, wc|
        wc[word] = @data.words.count(word)
      end

      @sentiment_word_counts = @sentiments.each_with_object({}) do |sentiment, wc|
        wc[sentiment] = @data.words(sentiment: sentiment).count
      end
      @sentiment_word_counts[:all] = @sentiment_word_counts.values.reduce(0, :+)

      @trained = true
    end

    def probability(word: word, sentiment: :all)
      if sentiment == :all
        @individual_word_counts[word].to_f / @sentiment_word_counts[:all].to_f
      else
        word_count = @data.words(sentiment: sentiment).count(word)
        sentiment_count = @sentiment_word_counts[sentiment].to_f
        word_count / sentiment_count
      end
    end

    def trained?
      @trained
    end
  end
end

