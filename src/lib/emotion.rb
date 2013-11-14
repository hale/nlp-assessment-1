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

    def data(set: set)
      raise Exception.new("Invalid set.") unless %i(test train dev).include? set
      File.readlines("#{name}_#{set}.txt")
    end

  end
end
