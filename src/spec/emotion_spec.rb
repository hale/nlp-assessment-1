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

      describe "#data loading from disk" do
        it "loads a dev set" do
          File.should_receive(:readlines).with("test_dev.txt").and_return []
          Emotion.new(:test).data(set: :dev).should eq([])
        end

        it "loads a test set" do
          File.should_receive(:readlines).with("test_test.txt").and_return []
          Emotion.new(:test).data(set: :test).should eq([])
        end

        it "loads a training set" do
          File.should_receive(:readlines).with("test_train.txt").and_return []
          Emotion.new(:test).data(set: :train).should eq([])
        end

        it "raises an exception when no data file can be found" do
          expect { Emotion.new(:test).data(set: dev) }.to raise_error
        end

        it "raises an exception when the set name is invalid" do
          expect { Emotion.new(:test).data(set: :error) }.to raise_error
        end
      end

    end
  end
end
