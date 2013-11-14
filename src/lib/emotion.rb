module EmotionClassifier
  class Emotion
    attr_reader :name

    def initialize(name)
      @name = name
      @sentences = load_sentences(name)
    end

    def to_s
      name.to_s.capitalize
    end

    def negate_to_s
      "Not #{name}"
    end

    private

    def load_sentences(name)
      File.readlines("#{name}.txt")
    end
  end
end
