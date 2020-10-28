require 'spec_helper'
# rubocop: disable RSpec/VerifiedDoubles, RSpec/AnyInstance
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

  context 'with loglevel set to `crit`' do
    it 'shows a critical log message' do
      expect(Puppet).to receive(:crit).with('/Echo[TestMessage]/message: TestMessage')
      my_type.new(name: default_title, loglevel: 'crit')
    end
  end

  context 'with schedule set`' do
    context 'unknown schedule' do
      it 'fails with an error' do
        catalog = double('catalog')
        expect(catalog).to receive(:resource).and_return(nil)
        allow_any_instance_of(my_type).to receive(:catalog).and_return(catalog)
        expect { my_type.new(name: default_title, message: 'test message', schedule: 'unknown') }.to raise_error(RuntimeError, %r{Could not find schedule unknown})
      end
    end

    context 'within known schedule' do
      it 'sends that message' do
        allow_any_instance_of(my_type).to receive(:scheduled?).and_return(true)
        my_type.new(name: default_title, message: 'test message', schedule: 'within')
      end
    end

    context 'outside known schedule' do
      it 'doesn\'t sends a message' do
        allow_any_instance_of(my_type).to receive(:scheduled?).and_return(false)
        my_type.new(name: default_title, message: 'test message', schedule: 'outside')
      end
    end
  end
end
