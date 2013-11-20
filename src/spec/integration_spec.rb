require_relative 'spec_helper'

module EmotionClassifier
  class IntegrationSpec
    describe "classification" do
      before(:each) do
        if ENV['RB_PROF']
          puts "Profiling code (expect 2~3x slowdown)"
          RubyProf.start
        end
      end

      xit "should classify known angry-text as angry" do
        classifier = Classifier.new(:sentiments => [:angry, :fearful])
        emotion = classifier.classify(sentence: "You must")
        emotion.should eq(Emotion.new(:angry))
      end

      it "should classify known fearful-text as fearful" do
        classifier = Classifier.new(:sentiments => [:angry, :fearful])
        emotion = classifier.classify(sentence: "Charming!")
        emotion.should eq(Emotion.new(:fearful))
      end

      after(:each) do
        if ENV['RB_PROF']
          result = RubyProf.stop
          printer = RubyProf::FlatPrinter.new(result)
          printer.print(File.new('tmp/ruby_prof.txt', 'w'))
          puts "Wrote tmp/ruby_prof.txt"
        end
      end
    end
  end
end


