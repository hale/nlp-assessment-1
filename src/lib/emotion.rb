module EmotionClassifier
  class Emotion
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def to_s
      name.to_s.capitalize
    end

    def negate_to_s
      "Not #{name}"
    end

    def ==(other)
      name == other.name
    end
  end
end
