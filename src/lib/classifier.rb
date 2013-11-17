module EmotionClassifier
  class Classifier
    attr_reader :emotions
    attr_reader :data

    def initialize(sentiments: sentiments)
      sentiments.each_with_object([]) do |sentiment, emotions|
        (@emotions ||= []) << Emotion.new(sentiment)
      end

      @data = DataSet.new(sentiments)
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

