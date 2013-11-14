require 'spec_helper'

module EmotionClassifier
  class ClassifierSpec
    describe Classifier do
      it "should classify known angry-text as angry" do
        classifier = Classifier.new
        emotion = classifier.classify(sentence: "I hate you!")
        emotion.should eq(Emotion.new(:angry))
      end

      xit "should classify known fearful-text as fearful" do
        classifier = Classifier.new
        emotion = classifier.classify(sentence: "Please don't hurt me.")
        emotion.should eq(Emotion.new(:fearful))
      end
    end
  end
end
