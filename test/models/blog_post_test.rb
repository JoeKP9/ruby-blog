require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  
  test "draft? returns true for post with nil published at date" do
    assert BlogPost.new(published_at: nil).draft?
  end

  test "draft? returns false for post with past published at date" do
    refute BlogPost.new(published_at: 1.year.ago).draft?
  end

  test "draft? returns false for post with future published at date" do
    refute BlogPost.new(published_at: 1.year.from_now).draft?
  end


  test "scheduled? returns false for post with nil published at date" do
    refute BlogPost.new(published_at: nil).scheduled?
  end

  test "scheduled? returns false for post with past published at date" do
    refute BlogPost.new(published_at: 1.year.ago).scheduled?
  end

  test "scheduled? returns true for post with future published at date" do
    assert BlogPost.new(published_at: 1.year.from_now).scheduled?
  end

end
