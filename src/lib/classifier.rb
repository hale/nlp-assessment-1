module EmotionClassifier
  require 'bigdecimal'

  class Classifier
    attr_reader :sentiments
    attr_reader :data
    attr_reader :individual_word_counts
    attr_reader :sentiment_word_counts

    def initialize(sentiments: sentiments, report: false)
      @sentiments = sentiments
      @data = DataSet.new(sentiments)
    end

    def classify_dev_set
      score = 0
      sentences = @data.dev.sample(3)
      sentences.each do |sentence, expected|
        actual = classify(sentence: sentence)
        score +=1 if actual == expected
      end
      accuracy = score.to_f / sentences.count.to_f * 100.0
      #puts "== ACCURACY REPORT =="
      #puts "Sentence count: #{sentences.count}"
      #puts "Accuracy:       #{accuracy}"
    end

    def classify(sentence: sentence)
      sentiments.each_with_object({}) do |sentiment, p|
        p[sentiment] = @data.word_count(sentiment: sentiment) / @data.word_count
        sentence.downcase.split.each do |word|
          prob = probability(word: word, sentiment: sentiment)
          p[sentiment] *= prob if prob > 0
        end
      end.max_by { |sentiment, _| sentiment }.first
    end

    def sentiment_word_count(sentiment)
      @data.words(sentiment: sentiment).count
    end

    def probability(word: word, sentiment: :all)
      @data.word_count(word: word) / @data.word_count(sentiment: sentiment)
    end

    def print_report(probabilities)
      @data.use_set :all
      score = 0
      classifications.each do |sentence, classification|
        expected = @data.set[sentence]
        actual = classification
        score += 1 if expected == actual
      end
    end
  end
end

