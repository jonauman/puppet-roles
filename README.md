# Roles

For a basic overview of roles (and profiles), you can read this blog post:
http://www.craigdunn.org/2012/05/239/

This class assigns custom facts, such as locaion, environment, and roles. The facts are created based on your naming scheme for hostname.

The naming scheme should be [location]-[environment]-[role]-[context]-[node_number], with each element separated by a single dash.

The following custom facts are created:

```
location: [ aws, dc1, rackspaceuk, etc. ]
env: [ dev, ci, qa, staging, prod, etc. ]
role: [ app, web, db, etc. ]
context: [ backend, frontend, etc. ]
node: [ 1, 01, 99, etc. ]
```

If an element is missing, it's value will be nil. For example, context is optional. We used it to denote backend or frontend for our app servers.

So if the hostname is 'Ec2EuWest1-qa-web-01' your facts will be:

```
facter location env role context node
context => nil
env => qa
location => Ec2EuWest1
node => 1
role => web
```

## Usage

An example hiera.yaml and hieradata directory is included.

In our example, hiera will look for a yaml file in the hieradata/roles directory that matches the nodes role. You should list all your classes and role variables in this yaml file. You don't need separate directories for your yaml files in hiera as there is no autoloading, but it does help keep things tidy.

Back to our example web server, hiera will apply the contents of roles/web.yaml on the second puppet run. The second run is necessary because the first run installs the custom fact (role) and the facts are evaluated at the beginning of a puppet run.

## Troubleshooting


### Facter

- With newer versions of facter, you need to run facter as root on the command line to see custom facts.
- facter version 2.x seem to load custom facts differently
- older versions of facter don't show any custom facts

Therefore it is recommended to stick with the latest version of facter 1.x (i.e, 1.7.6).

``` gem install facter --version 1.7.6 ```

### Puppet

- You will need puppet version 3.x. Some of the earlier versions of puppet 3 were somewhat buggy, so you may need to upgrade.
