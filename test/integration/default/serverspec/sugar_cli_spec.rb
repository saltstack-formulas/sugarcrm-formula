require "serverspec"

# Set backend type
set :backend, :exec

describe 'sugarcrm cli tool' do

    sugarcli = '/usr/local/bin/sugarcli'

    describe file(sugarcli) do
        it { should exist }
        it { should be_mode 740 }
        it { should be_owned_by 'www-data' }
        it { should be_grouped_into 'www-data' }
    end
end