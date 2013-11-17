module EmotionClassifier
  class DataSet
    PATH = '../emotions'

    attr_reader :training

    def initialize(sentiment)
      data = File.readlines(make_path(sentiment))
      @training = data.shuffle.first_percent(80)
    end

    private

    def make_path(filename)
      "#{PATH}/#{filename}.txt"
    end
  end
end
