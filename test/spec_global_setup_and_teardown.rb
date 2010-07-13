require 'test/spec'

require 'test/spec/dox'

$before_each = false
$before_all_count = 0

context "Global setup and teardown" do
  specify "can be configured" do
    Test::Spec.should.respond_to(:configure)
    Test::Spec.should.respond_to(:configuration)
    Test::Spec.configure { |c| Test::Spec.configuration.should == c }
  end
  
  specify "should have a before hook" do
    Test::Spec.configuration.should.respond_to(:before)
  end
  
  specify "should have an after hook" do
    Test::Spec.configuration.should.respond_to(:after)
  end
  
  context "should apply before(:each) to tests:" do
    Test::Spec.configuration.before(:each) { $before_each = true }
    Test::Spec.configuration.after(:each) { $before_each = nil }
    specify "before_each should be true" do
      $before_each.should == true
    end
  end

  # Can't figure out where to hook these in. It's implemented in Test::Spec::Configuration but without hooks they
  # never fire.
#  context "should apply before(:all) to tests:" do
#    Test::Spec.configuration.before(:all) { $before_all_count = $before_all_count.to_i + 1 }
#    specify "before_each should be true" do
#      $before_all_count.should == 1
#    end
#    specify "before_each should be true" do
#      $before_all_count.should == 1
#    end
#  end
end
  
