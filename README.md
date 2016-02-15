# dm-crypt Cookbook
[![Build Status](https://travis-ci.org/kemra102/dm-crypt-cookbook.svg?branch=master)](https://travis-ci.org/kemra102/dm-crypt-cookbook)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage](#usage)
    * [dmcrypt_device](#dmcrypt_device)
4. [Contributing](#contributing)
5. [License & Authors](#license-and-authors)

## Overview

This cookbook provides a way to format devices with LUKS via `dm-crypt`. Other encryption options supported by `dm-crypt` as well as other features will be added in time.

## Requirements

Requires Chef 12.5 or later as this cookbook makes use of [Custom Resources](https://www.chef.io/blog/2015/10/08/chef-client-12-5-released/).

## Usage

You always need to include the main recipe:

```ruby
include_recipe 'dm-crypt::default'
```

This installs 2 packages:

* `cryptsetup` - Utilities for interacting with dm-crypt.
* `file` - Used to determine if devices are correctly formatted.

### dmcrypt_device

Each device to be formatted by dm-crypt is defined by a `dmcrypt_device` custom resource.

Each `dmcrypt_device` has the following attributes:

| Attribute  | Type   | Description                                      | Default |
|:----------:|:------:|:------------------------------------------------:|:-------:|
| name       | String | Resource name.                                   | N/A     |
| device     | String | The absolute path to the device to be formatted. | N/A     |
| passphrase | String | Passphrase used to encrypt the device.           | N/A     
| keyfile    | String | Key file used to encrypt the device.             | N/A     |

> NOTE: You must supply either a `passphrase` or a `keyfile` but never both.

To encrypt an LVM partition:

```ruby
dmcrypt_device 'enc_data' do
  device '/dev/mapper/vg_enc-lv_data'
  passphrase 'supersecretword'
end
```

## Contributing

If you would like to contribute to this cookbook please follow these steps;

1. Fork the repository on Github.
2. Create a named feature branch (like `add_component_x`).
3. Write your change.
4. Write tests for your change (if applicable).
5. Run the tests, ensuring they all pass.
6. Submit a Pull Request using Github.

## License and Authors

License: [BSD 2 Clause](https://tldrlegal.com/license/bsd-2-clause-license-\(freebsd\)

Authors:

  * [Danny Roberts](https://github.com/kemra102)
  * [All Contributors](https://github.com/kemra102/dm-crypt-cookbook/graphs/contributors)
