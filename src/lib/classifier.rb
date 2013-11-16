module EmotionClassifier
  class Classifier
    def initialize(sentiments: sentiments)
      @emotions = [].tap do |emotions|
        sentiments.each { |sentiment| emotions << Emotion.new(:sentiment) }
      end
    end

    def classify(sentence: sentence)
      train
      Emotion.new(:angry)
    end

    def train
      @trained = true
    end

    def trained?
      @trained
    end
  end
end

