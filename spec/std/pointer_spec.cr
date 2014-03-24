#!/usr/bin/env bin/crystal --run
require "spec"

describe "Pointer" do
  describe "memmove" do
    it "performs with overlap right to left" do
      p1 = Pointer.malloc(4) { |i| i }
      (p1 + 1).memmove(p1 + 2, 2)
      p1[0].should eq(0)
      p1[1].should eq(2)
      p1[2].should eq(3)
      p1[3].should eq(3)
    end

    it "performs with overlap left to right" do
      p1 = Pointer.malloc(4) { |i| i }
      (p1 + 2).memmove(p1 + 1, 2)
      p1[0].should eq(0)
      p1[1].should eq(1)
      p1[2].should eq(1)
      p1[3].should eq(2)
    end
  end

  describe "memcmp" do
    assert do
      p1 = Pointer.malloc(4) { |i| i }
      p2 = Pointer.malloc(4) { |i| i }
      p3 = Pointer.malloc(4) { |i| i + 1 }

      p1.memcmp(p2, 4).should be_true
      p1.memcmp(p3, 4).should be_false
    end
  end

  it "compares two pointers by address" do
    p1 = Pointer(Int32).malloc(1)
    p2 = Pointer(Int32).malloc(1)
    p1.should eq(p1)
    p1.should_not eq(p2)
    p1.should_not eq(1)
  end
end
