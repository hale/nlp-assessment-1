require_relative 'spec_helper'

module EmotionClassifier
  class EmotionSpec
    describe Emotion do
      it "#to_string gives the name of the emotion" do
        File.should_receive(:readlines).and_return []
        Emotion.new(:test).to_s.should eq("Test")
      end

      it "#negate_to_s gives a string representing the opposite emotion" do
        File.should_receive(:readlines).and_return []
        Emotion.new(:test).negate_to_s.should eq("Not test")
      end

      it "can be initialised when accompanying data file is found" do
        File.should_receive(:readlines).with("test.txt").and_return []
        expect { Emotion.new(:test) }.to_not raise_error
      end

      it "raises an exception when no data file can be found" do
        expect { Emotion.new(:test) }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
