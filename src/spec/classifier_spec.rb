require 'spec_helper'

module EmotionClassifier
  class ClassifierSpec
    describe Classifier do
      before(:each) { File.stub(:readlines => ["Test"]) }

      let(:classifier) { Classifier.new(sentiments: [:testable]) }

      it "should be untrained by default" do
        classifier.trained?.should_not be_true
      end

      it "should be initialised with some emotions" do
        classifier = Classifier.new(sentiments: [:example])
        classifier.emotions.should eq([Emotion.new(:example)])
      end

      describe "initialized with data" do
        let(:classifier) { Classifier.new(sentiments: [:example]) }

        it "has a training set" do
          classifier.data[:example].train.should_not be_nil
        end

        it "has a dev-set of data to test against" do
          classifier.data[:example].dev.should_not be_nil
        end

        it "has a held-back set of test data" do
          classifier.data[:example].test.should_not be_nil
        end
      end

      it "#train should train the classifier" do
        classifier.train
        classifier.trained?.should be_true
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
