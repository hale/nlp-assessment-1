require_relative 'spec_helper'

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

      it "splits the data into 80/10/10 for training/test/dev" do
        data = DataSet.new(sentiments.keys)
        data.test.size.should eq(3)
        data.dev.size.should eq(3)
        data.train.size.should eq(24)
      end

      it "can give all the data" do
        data = DataSet.new(sentiments.keys)
        data.all.count.should eq(30)
      end

      it "assigns a sentiment to each sentence" do
        data = DataSet.new(sentiments.keys)
        data.all.select{ |word, sentiment| sentiment == :green }
          .map(&:first).should eq(sentiments[:green])
      end

      it "has a total word count equal to the training dataset size" do
        data = DataSet.new(sentiments.keys)
        data.word_counts[:all].should eq(24)
      end

      it "has wordcounts for each sentiment, which sum to the total wordcount" do
        word_counts = DataSet.new(sentiments.keys).word_counts
        word_counts[:red].should be > 0
        word_counts[:green].should be > 0
        word_counts[:blue].should be > 0
        (word_counts[:red] + word_counts[:green] + word_counts[:blue]).should eq(24)
      end

      it "#count_in_context gives the number of times the given word appears in the given context" do
        data = DataSet.new(sentiments.keys)
        data.count_in_context(word: 'g2', sentiment: :green).should eq(1)
      end

      it "#probability with only word argument gives proportion of that word in the dataset" do
        data = DataSet.new(sentiments.keys)
        data.probability(word: 'g1').should eq(1/30)
      end

      it "#probability with word and sentiment arguments gives proportion of that word for that sentiment" do
        data = DataSet.new(sentiments.keys)
        data.probability(word: 'g1', sentiment: :green).should eq(1/30)
        data.probability(word: 'g1', sentiment: :blue).should eq(0/30)
      end
    end
  end
end
