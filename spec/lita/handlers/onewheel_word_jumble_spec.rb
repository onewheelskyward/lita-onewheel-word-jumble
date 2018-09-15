require 'spec_helper'

describe Lita::Handlers::OnewheelWordJumble, lita_handler: true do

  before(:each) do
    # registry.configure do |config|
    #   config.handlers.onewheel_word_jumble.api_key = 'xyz'
    # end
  end

  it { is_expected.to route_command('words abcde 3') }
  it { is_expected.to route_command('words abcde') }

  it 'solves yer jumble' do
    send_command 'words aelb'
    expect(replies.last).to_not be(nil)
    expect(replies.count).to be(1)
    expect(replies.last).to eq('abe, abel, able, alb, albe, ale, bae, bal, bale, bea, beal, bel, bela, blae, elb, lab, lea')
  end

  it 'solves yer jumble' do
    send_command 'words aelb 4'
    expect(replies.last).to_not be(nil)
    expect(replies.count).to be(1)
    expect(replies.last).to eq('abel, able, albe, bale, beal, bela, blae')
  end

  it 'solves yer jumble' do
    send_command 'words aelb 3'
    expect(replies.last).to_not be(nil)
    expect(replies.count).to be(1)
    expect(replies.last).to eq('abe, alb, ale, bae, bal, bea, bel, elb, lab, lea')
  end
end
