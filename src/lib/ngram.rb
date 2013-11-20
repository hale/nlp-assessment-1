module EmotionClassifier
  class Ngram
    def initialize(sentence)
      @sentence = sentence
    end

    def ngrams(n)
      if @sentence.class == String
        @sentence.split(' ').each_cons(n).to_a
      else
        @sentence.each_cons(n).to_a
      end
    end

    def bigrams
      ngrams(2)
    end

    def trigrams
      ngrams(3)
    end
  end
end
