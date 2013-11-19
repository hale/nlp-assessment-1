require_relative '../spec_helper'

module EmotionClassifier
  class DataSetSpec
    describe DataSet do
      let(:sentiments) do
        {:red => %w{r1 r2 r3 r4 r5 r6 r7 r8 r9 r10},
         :green => %w{g1 g2 g3 g4 g5 g6 g7 g8 g9 g10},
         :blue => %w{b1 b2 b3 b4 b5 b6 b7 b8 b9 b10} }
      end

      before(:each) do
        File.stub(:readlines).and_return(sentiments[:red], sentiments[:green], sentiments[:blue])
      end

      it "#sentences strips the sentence of punctuation and downcases" do
        File.stub(:readlines).and_return(['"My oh my", said Ronald\'s tiger!'])
        data = DataSet.new([:test])
        data.set.first.first.should eq("my oh my said ronalds tiger")
      end

      it "splits the data into 80/10/10 for training/test/dev" do
        data = DataSet.new(sentiments.keys)
        data.use_set(:test).size.should eq(3)
        data.use_set(:dev).size.should eq(3)
        data.use_set(:train).size.should eq(24)
      end

      it "can give all the data" do
        data = DataSet.new(sentiments.keys)
        data.use_set :all
        data.set.count.should eq(30)
      end

      it "assigns a sentiment to each sentence" do
        data = DataSet.new(sentiments.keys)
        data.set.select{ |word, sentiment| sentiment == :green }
          .map(&:first).should eq(sentiments[:green])
      end

      it "#with_sentiment gives the sentences with a given sentement" do
        data = DataSet.new(sentiments.keys)
        data.with_sentiment(:green).map(&:first).should eq(sentiments[:green])
      end

      it "#words gives an array with every word by default" do
        data = DataSet.new(sentiments.keys)
        data.words.should eq(sentiments.values.flatten)
      end

      it "#words with sentiment argument gives words in that sentiment" do
        data = DataSet.new(sentiments.keys)
        data.words(sentiment: :red).should eq(sentiments[:red])
      end
    end
  end
end
