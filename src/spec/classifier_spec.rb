require 'spec_helper'

module EmotionClassifier
  class ClassifierSpec
    describe Classifier do
      it "should classify known angry-text as angry" do
        classifier = Classifier.new
        classifier.classify(text: 'dev_set_angry').should eq(:angry)
      end

      it "should classify known fearful-text as fearful" do
        classifier = Classifier.new
        classifier.classify(text: 'dev_set_fearful').should eq(:fearful)
      end
    end
  end
end
