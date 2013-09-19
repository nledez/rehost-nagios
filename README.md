rehost-nagios Cookbook
=====================
Install and configure Nagios for ReHost hosting customers.

Build status
------------
[![Build Status](https://travis-ci.org/nledez/rehost-nagios.png)](https://travis-ci.org/nledez/rehost-nagios)

Requirements
------------
ReHost hosting
Debian, Ubuntu

Attributes
----------
#### rehost-nagios::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rehost-nagios']['allowed_hosts']</tt></td>
    <td>String</td>
    <td>Host list allowed to connect on nrpe server</td>
    <td><tt>127.0.0.1,91.121.88.157,87.98.179.41</tt></td>
  </tr>
</table>

Usage
-----
#### rehost-nagios::default

Just include `rehost-nagios` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[rehost-nagios]"
  ]
}
```

All there modules are availables:
rehost-nagios
rehost-nagios::clamav
rehost-nagios::imap
rehost-nagios::md
rehost-nagios::mon
rehost-nagios::mysql
rehost-nagios::nginx
rehost-nagios::vz


License and Authors
-------------------
Closed source for now
All right reserved
Authors: Nicolas Ledez nicolas@ledez.net
