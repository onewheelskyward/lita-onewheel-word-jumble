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
    expect(replies.last).to include('able')
  end
end
