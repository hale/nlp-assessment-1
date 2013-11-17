module EmotionClassifier
  module ArrayExtensions
    def first_percent(percent)
      take((size * percent / 100.0).ceil)
    end
  end
end


class Array
  include EmotionClassifier::ArrayExtensions
end
