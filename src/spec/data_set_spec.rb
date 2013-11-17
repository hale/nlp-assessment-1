require_relative 'spec_helper'

module EmotionClassifier
  class DataSetSpec
    describe DataSet do
      it "splits the data into 80/10/10 for training/test/dev" do
        sentiments = {
          :red => %w{r1 r2 r3 r4 r5 r6 r7 r8 r9 r10},
          :blue => %w{b1 b2 b3 b4 b5 b6 b7 b8 b9 b10},
          :green => %w{g1 g2 g3 g4 g5 g6 g7 g8 g9 g10}
        }
        File.stub(:readlines).and_return(sentiments[:red], sentiments[:green], sentiments[:blue])

        data = DataSet.new(sentiments.keys)

        data.test.size.should eq(3)
        data.dev.size.should eq(3)
        data.train.size.should eq(24)
      end
    end
  end
end
