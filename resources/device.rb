resource_name :dmcrypt_device

property :name, String, required: true, name_property: true
property :device, String, required: false
property :passphrase, String, required: false
property :keyfile, String, required: false

default_action :create

def real_device
  device || name
end

def real_name
  name.gsub(/\s/, '_')
end

action :create do
  if passphrase.nil? && keyfile.nil?
    Chef::Application.fatal!("You MUST supply either a passphrase or
                             keyfile for #{name}!", 2)
  end
  if passphrase && keyfile
    Chef::Application.fatal!("You MUST supply either a passphrase or
                             keyfile for #{name}, not both!", 3)
  end

  if passphrase
    ruby_block 'create-device-passphrase' do
      block do
        DMCrypt::Helper.create_device_passphrase(passphrase, real_device)
      end
      action :run
      not_if { DMCrypt::Helper.encrypted?(real_device) }
    end
  else
    ruby_block 'create-device-keyfile' do
      block do
        DMCrypt::Helper.create_device_keyfile(keyfile, real_device)
      end
      action :run
      not_if { DMCrypt::Helper.encrypted?(real_device) }
    end
  end
end

action :delete do
  ruby_block 'close-device' do
    block do
      DMCrypt::Helper.close_device(real_name)
      action :run
    end
  end
end
