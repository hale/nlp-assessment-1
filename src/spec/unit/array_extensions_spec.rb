require_relative '../spec_helper'

module EmotionClassifier
  class ArrayExtensionsSpec
    describe "ArrayExtensions#first_percent" do
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

      it "supports empty arrays" do
        [].first_percent(91).should eq([])
      end

      it "with 0 gives the empty array" do
        [1, 2].first_percent(0).should eq([])
      end

      context "graceful degradation" do
        it "treats >100 percentages as 100" do
          [1, 2].first_percent(219).should eq([1,2])
        end

        it "treats <0 percentages as 0" do
          [1, 2].first_percent(-192).should eq([])
        end
      end
    end
  end
end
