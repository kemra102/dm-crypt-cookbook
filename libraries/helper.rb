module DMCrypt
  # Helper module for dm-crypt cookbook_file
  module Helper
    extend Chef::Mixin::ShellOut

    def self.close_device(name)
      shell_out!("cryptsetup luksClose #{name}")
    end

    def self.create_device_keyfile(keyfile, device)
      shell_out!("cryptsetup -d #{keyfile} luksFormat #{device}")
    end

    def self.create_device_passphrase(passphrase, device)
      shell_out!("cryptsetup luksFormat #{device} -", input: passphrase)
    end

    def self.encrypted?(device)
      shell_out!("[ $(file --dereference --special-files #{device} | cut -d\' \' -f3) == \'encrypted\' ]") # rubocop:disable Metrics/LineLength
    rescue StandardError
      false
    end
  end
end
