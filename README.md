# Intro 

A puppet module which sets up [redis](http://redis.io/) using a package.

# Usage

```puppet
# supports Centos and Ubuntu
class{ 'redis':
    append => true
}
redis::bind {'allow all':
  bind => '0.0.0.0'
}

```

See [redis-sandbox](https://github.com/narkisr/redis-sandbox) for a fully working sandbox.

# Copyright and license

Copyright [2013] [Ronen Narkis]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at:

  [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
