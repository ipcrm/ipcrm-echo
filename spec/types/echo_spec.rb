require 'spec_helper'

describe 'echo', type: :type do
  let(:my_type) { Puppet::Type.type(:echo) }
  let(:default_title) { 'TestMessage' }

  context 'with default parameters' do
    it 'default to using the name as the message' do
      expect(Puppet).to receive(:notice).with('/Echo[TestMessage]/message: TestMessage')
      my_type.new(name: default_title)
    end
  end

  context 'with a specific message' do
    it 'sends that message' do
      expect(Puppet).to receive(:notice).with('/Echo[TestMessage]/message: test message')
      my_type.new(name: default_title, message: 'test message')
    end
  end

  context 'with `withpath` set to false' do
    it 'do not show the resource path' do
      expect(Puppet).to receive(:notice).with('TestMessage')
      my_type.new(name: default_title, withpath: false)
    end
  end

  context 'with `refreshonly` set to `true`' do
    it 'does not display anything' do
      expect(Puppet).not_to receive(:notice)
      my_type.new(name: default_title, refreshonly: true)
    end
  end
  # TODO: figure out how to test the refresh notification
end
