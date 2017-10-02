require 'rails_helper'

RSpec.describe NoRetryJobs do
  describe '#call' do
    context 'when the queue is idv' do
      it 'runs' do
        count = 0
        NoRetryJobs.new.call(nil, nil, 'idv') { count += 1 }

        expect(count).to eq 1
      end

      it 'sets retry to false when rescuing StandardError then raises the error' do
        msg = {}
        expect { NoRetryJobs.new.call(nil, msg, 'idv') { raise StandardError } }.
          to change { msg }.from({}).to('retry' => false).and raise_error(StandardError)
      end
    end

    context 'when the queue is not idv' do
      it 'does not run' do
        count = 0
        NoRetryJobs.new.call(nil, {}, 'foo') { count += 1 }

        expect(count).to eq 0
      end
    end
  end
end
