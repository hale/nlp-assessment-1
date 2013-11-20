require_relative '../spec_helper'

module EmotionClassifier
  class NgramSpec
    describe Ngram do
      it "#bigrams gives array of bigrams" do
        ngram = Ngram.new("a b c")
        ngram.bigrams.should eq([['a', 'b'], ['b', 'c']])
      end

      it "#trigrams gives array of trigrams" do
        ngram = Ngram.new("a b c d")
        ngram.trigrams.should eq([['a', 'b', 'c'], ['b', 'c', 'd']])
      end

      it "can give arbitrary numbered n-grams" do
        ngram = Ngram.new("a b c d e")
        ngram.ngrams(4).should eq([['a', 'b', 'c', 'd'], ['b', 'c', 'd', 'e']])
      end

      it "treats word+punctuation as different from word" do
        ngram = Ngram.new("Hello, world!")
        ngram.ngrams(1).should eq([["Hello,"], ["world!"]])
      end

      it "#ngrams works with arrays as well as sentences" do
        ngram = Ngram.new(["my", "name", "is"])
        ngram.ngrams(2).should eq([['my', 'name'], ['name', 'is']])
      end
    end
  end
end
