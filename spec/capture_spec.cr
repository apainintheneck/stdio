require "./spec_helper"

module StdioCaptureFeature
  describe name do
    it "captures" do
      output, error, input = Stdio.capture do |io|
        STDOUT.puts ":)"
        STDERR.puts ":("
        io.in.puts ":P"
        [io.out.gets, io.err.gets, STDIN.gets]
      end
      output.should eq ":)"
      error.should eq ":("
      input.should eq ":P"
    end

    it "keeps capturing" do
      Stdio.capture do |io|
        STDOUT.puts ":)"
        io.out!.gets.should eq ":)"
        STDOUT.puts ":X"
        io.out!.gets.should eq ":X"
      end
    end
  end
end
