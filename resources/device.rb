resource_name :dmcrypt_device

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
  if new_resource.passphrase.nil? && new_resource.keyfile.nil?
    Chef::Application.fatal!("You MUST supply either a passphrase or
                             keyfile for #{name}!", 2)
  end
  if new_resource.passphrase && new_resource.keyfile
    Chef::Application.fatal!("You MUST supply either a passphrase or
                             keyfile for #{name}, not both!", 3)
  end

  if new_resource.passphrase
    ruby_block 'create-device-passphrase' do
      block do
        DMCrypt::Helper.create_device_passphrase(new_resource.passphrase, real_device) # rubocop:disable Metrics/LineLength
      end
      action :run
      not_if { DMCrypt::Helper.encrypted?(real_device) }
    end
  else
    ruby_block 'create-device-keyfile' do
      block do
        DMCrypt::Helper.create_device_keyfile(new_resource.keyfile, real_device)
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
