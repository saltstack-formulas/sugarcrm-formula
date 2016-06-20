require "serverspec"

# Set backend type
set :backend, :exec

describe 'sugarcrm archive download' do

    sugarcrm_zip = '/tmp/sugarcrm.zip'

    describe file(sugarcrm_zip) do
        it { should exist }
        it { should be_mode 640 }
        it { should be_owned_by 'www-data' }
        it { should be_grouped_into 'www-data' }
    end
end

describe 'sugarcrm custom archive download' do

    sugarcrm_zip = '/tmp/sugarcrm_sitenameB.com.zip'

    describe file(sugarcrm_zip) do
        it { should exist }
        it { should be_mode 640 }
        it { should be_owned_by 'www-data' }
        it { should be_grouped_into 'www-data' }
    end
end