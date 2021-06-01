# PS-DHCPv6

## Introduction

This is used to automate creating DHCPv6 scopes on Windows DHCP servers.

## Files

* config.ps1.example - create a copy of this named config.ps1 and add the appropriate information. The networks located in the file are in the documentation prefix, so do not keep them as-is: https://help.apnic.net/s/article/IPv6-Documentation-prefix
* create-scopes.ps1 - create the scopes defined in the config.ps1 script
* create-exclusions.ps1 - create exclusions as defined in the config.ps1 script

## FAQs

Not that anyone has asked but here are a few questions I anticipate.

Q) Why doesn't this handle reservations?  
A) I don't have a need for reservations at the moment.

Q) Why isn't there an option to set DNS server addresses?  
A) In my environment, the DNS server settings are defined above the scope level, at the server level. 

Q) Why aren't you setting router addresses? That's a normal thing to do at the scope level!  
A) IPv6 uses router announcements, not DHCP scope options for this.

Q) Why not use a datasource like a CSV instead?  
A) You are welcome to modify the code to point to your CSV instead. Probably wouldn't take a lot of effort. I created this for a relatively small set of networks so it was less work to make a hash table.
