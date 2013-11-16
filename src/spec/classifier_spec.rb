require 'spec_helper'

module EmotionClassifier
  class ClassifierSpec
    describe Classifier do
      let(:classifier) { Classifier.new(sentiments: [:testable]) }

      it "should be untrained by default" do
        classifier.trained?.should_not be_true
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
