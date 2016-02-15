include_recipe 'dm-crypt::default'

execute 'fallocate' do
  command 'fallocate -l 512M /testfile'
  creates '/testfile'
end

dmcrypt_device '/testfile' do
  passphrase 'ilikepasswords'
end
