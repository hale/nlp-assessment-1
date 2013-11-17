module EmotionClassifier
  module ArrayExtensions
    def first_percent(percent)
      return [] if percent < 0
      take((size * percent / 100.0).ceil)
    end
  end
end


class Array
  include EmotionClassifier::ArrayExtensions
end
