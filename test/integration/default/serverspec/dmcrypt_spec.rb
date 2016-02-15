require 'serverspec'

set :backend, :exec

describe file('/testfile') do
  it { should be_file }
end

describe command('file --dereference --special /testfile | cut -d" " -f 3') do
  its(:stdout) { should match /^encrypted$/ }
end
