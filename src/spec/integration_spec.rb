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

      describe "#classify" do
        let(:classifier) { Classifier.new(sentiments: [:angry, :fearful], report: true) }

        xit "should classify known angry-text as angry" do
          emotion = classifier.classify(sentence: "You must")
          emotion.should eq(:angry)
        end

        it "should classify known fearful-text as fearful" do
          emotion = classifier.classify(sentence: "Charming!")
          emotion.should eq(:fearful)
        end
      end

      describe "#classify_dev_set" do
        let(:classifier) do
          sentiments = [:angry, :disgusted, :fearful, :happy, :sad, :surprised]
          Classifier.new(sentiments:  sentiments, report: true, )
        end

        it "doesn't crash at runtime" do
          classifier.classify_dev_set
        end
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


