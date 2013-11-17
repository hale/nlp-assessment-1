require_relative 'spec_helper'

module EmotionClassifier
  class ArrayExtensionsSpec
    describe "#first_percent" do
      its "with 10 gives the first 10% of an array" do
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].first_percent(10).should eq([1])
      end

      its "with 100 returns the array" do
        [:foo, :bar].first_percent(100).should eq([:foo, :bar])
      end

      it "rounds up " do
        arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        (arr.first_percent(32).count + arr.first_percent(68).count).should be > 10
      end
    end
  end
end
