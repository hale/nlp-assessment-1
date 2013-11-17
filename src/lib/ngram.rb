module EmotionClassifier
  class Ngram
    def initialize(sentence)
      @sentence = sentence
    end

    def ngrams(n)
      @sentence.split(' ').each_cons(n).to_a
    end

    def bigrams
      ngrams(2)
    end

    def trigrams
      ngrams(3)
    end
  end
end
