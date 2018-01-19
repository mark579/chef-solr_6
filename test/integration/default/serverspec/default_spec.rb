# frozen_string_literal: true

require 'spec_helper'

describe user('solr') do
  it { should exist }
  it { should belong_to_group 'solr' }
end

describe file('/etc/default/solr.in.sh') do
  it { should exist }
  it { should be_file }
  it { should be_readable }
  it { should contain '# Generated by Chef' }
end

describe service('solr') do
  it { should be_enabled }
end

describe file('/var/solr/data/test_core') do
  it { should exist }
  it { should be_directory }
end

describe file('/var/solr/data/test_core/core.properties') do
  it { should exist }
  it { should be_file }
  it { should be_readable }
  it { should be_owned_by 'solr' }
  it { should contain 'name=test_core' }
end

describe command('service solr status') do
  its(:stdout) { should match(/running on port 8983/) }
end
