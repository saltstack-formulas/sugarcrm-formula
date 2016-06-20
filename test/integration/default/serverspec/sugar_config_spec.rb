require "serverspec"

# Set backend type
set :backend, :exec

describe 'sugarcrm configuration' do

    configs = ['/etc/sugarcrm/sitenameA.com_config_si.php', '/etc/sugarcrm/sitenameB.com_config_si.php']

    configs.each do |config|
        describe file(config) do
            it { should exist }
            it { should be_file }
            it { should be_mode 640 }
            it { should be_owned_by 'www-data' }
            it { should be_grouped_into 'www-data' }
            it { should contain "dbuser" }
        end
    end

    describe file('/www/html/sitenameA.com/config_si.php') do
        it { should exist }
        it { should be_linked_to '/etc/sugarcrm/sitenameA.com_config_si.php' }
    end

    describe file('/www/html/sitenameB.com/config_si.php') do
        it { should exist }
        it { should be_linked_to '/etc/sugarcrm/sitenameB.com_config_si.php' }
    end    
end
