require_relative 'spec_helper'

module EmotionClassifier
  class EmotionSpec
    describe Emotion do
      it "#to_string gives the name of the emotion" do
        Emotion.new(:test).to_s.should eq("Test")
      end

      it "#negate_to_s gives a string representing the opposite emotion" do
        Emotion.new(:test).negate_to_s.should eq("Not test")
      end

      it "#== is true when emotions have the same name" do
        Emotion.new(:a).should eq(Emotion.new(:a))
      end
    end
  end
end
