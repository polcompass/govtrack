require 'helper'

describe GovTrack::Vote do

  it "should find an array of votes based on parameters" do
    votes = GovTrack::Vote.find(congress:112, session: 2011, chamber: 'house')
    votes.should be_an Array
    votes[0].should be_a GovTrack::Vote
  end

  it "should find an array of votes based on parameters with a dynamic finder" do
    votes = GovTrack::Vote.find_by_congress_and_session_and_chamber(112, 2011, 'house')
    votes.should be_an Array
    votes[0].should be_a GovTrack::Vote
  end

  it "should find a vote" do
    vote = GovTrack::Vote.find_by_id(1)
    vote.id.should eq 1
  end

  it "should retreive related_bill as a Bill and cache it" do
    vote = GovTrack::Vote.find_by_id(34577)
    vote.related_bill.should be_a GovTrack::Bill
    
    FakeWeb.allow_net_connect = false
    vote.related_bill.should be_a GovTrack::Bill
    FakeWeb.allow_net_connect = true
  end

  it "should retreive created as a DateTime object" do
    vote = GovTrack::Vote.find_by_id(34577)
    vote.created.should be_a DateTime
  end

end