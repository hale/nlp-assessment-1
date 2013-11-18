require 'spec_helper'

module EmotionClassifier
  class ClassifierSpec
    describe Classifier do
      before(:each) { File.stub(:readlines => ["Test"]) }

      let(:classifier) { Classifier.new(sentiments: [:testable]) }

      it "should be untrained by default" do
        classifier.trained?.should_not be_true
      end

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

      describe "#train" do
        let(:classifier) { Classifier.new(sentiments: [:red, :green]) }

        let(:sentiments) do
          { :red => ['xa', 'xb'],
            :green => ['1 2', '2 3', 'xc', 'xd', 'xe', 'xf', 'xg', 'xh'] }
        end

        before(:each) do
          File.stub(:readlines).and_return(sentiments[:red], sentiments[:green])
        end

        it "marks classifier as trained" do
          classifier.train
          classifier.trained?.should be_true
        end

        it "calculates #individual_word_counts" do
          classifier.train
          classifier.individual_word_counts['2'].should eq(2)
          classifier.individual_word_counts['1'].should eq(1)
          classifier.individual_word_counts['unknown'].should be_nil
        end

        it "calculates #sentiment_word_counts" do
          classifier.train
          classifier.sentiment_word_counts[:green].should eq(8)
          classifier.sentiment_word_counts[:red].should eq(0)
          classifier.sentiment_word_counts[:all].should eq(8)
        end

        it "#probability with only word argument gives proportion of that word in the dataset" do
          classifier.train
          classifier.probability(word: '1').should eq(1/10)
        end

        it "#probability with word and sentiment arguments gives proportion of that word for that sentiment" do
          classifier.train
          classifier.probability(word: '1', sentiment: :green).should eq(1/30)
          classifier.probability(word: '5', sentiment: :green).should eq(0/30)
        end
      end

      it "should classify known angry-text as angry" do
        emotion = classifier.classify(sentence: "I hate you!")
        emotion.should eq(Emotion.new(:angry))
      end

      xit "should classify known fearful-text as fearful" do
        emotion = classifier.classify(sentence: "Please don't hurt me.")
        emotion.should eq(Emotion.new(:fearful))
      end
    end
  end
end
