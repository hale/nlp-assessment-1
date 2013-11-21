require_relative '../spec_helper'

module EmotionClassifier
  class ClassifierSpec
    describe Classifier do
      before(:each) { File.stub(:readlines => ["Test"]) }

      let(:classifier) { Classifier.new(sentiments: [:testable]) }

      it "should be initialised with some sentiments" do
        classifier = Classifier.new(sentiments: [:example])
        classifier.sentiments.should eq([:example])
      end

      describe "initialized with data" do
        let(:classifier) { Classifier.new(sentiments: [:example]) }

        it "has a training set " do
          classifier.data.use_set(:train).should_not be_nil
        end

        it "has a dev-set of data to test against" do
          classifier.data.use_set(:dev).should_not be_nil
        end

        it "has a held-back set of test data" do
          classifier.data.use_set(:test).should_not be_nil
        end
      end

      describe "#probability" do
        let(:classifier) { Classifier.new(sentiments: [:red, :green]) }

        let(:sentiments) do
          { :red => ['xa', 'xb'],
            :green => ['1 2', '2 3', 'xc', 'xd', 'xe', 'xf', 'xg', 'xh'] }
        end

        before(:each) do
          File.stub(:readlines).and_return(sentiments[:red], sentiments[:green])
          classifier.data.use_set :train
        end

        it "#probability with only word argument gives proportion of that word in the dataset" do
          classifier.probability(word: '1').should eq(0.1)
        end

        it "#probability with word and sentiment arguments gives proportion of that word for that sentiment" do
          classifier.probability(word: '1', sentiment: :green).should eq(0.1)
          classifier.probability(word: '5', sentiment: :green).should eq(0.0)
        end

        xit "#probability works with higher order ngrams" do
          classifier.data.set_ngram_order(3)
          classifier.probability(word: ['1', '2']).should eq(1)
        end

      end
    end
  end
end
