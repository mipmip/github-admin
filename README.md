# Github Admin

Personal administration utility for housekeeping github accounts. Use with care
it deletes repos without warning.

## Features

- delete repos
- transfer repos to owned organisation

## Installation

Copy gdadm somewhere in your path. Tested on Linux only

## Usage

```
$ ghadm repo
    list     list repositories
    web      open repository in web browser
    delete   delete repository
    trans    transfer repository to owned organization
    rename   rename repository

$ ghadm org
    list              List repositories
    list-with-repos   List my organizations
```

## Features

* Repository
  * [x] list
  * [x] show in web browser
  * [x] delete
  * [x] transfer to organization
  * [x] rename
  * [ ] update topics
  * [ ] udpate description
* Organization
  * [x] list
  * [x] list with repositories

## Development

compile:

```
shard build
```

## Contributing

1. Fork it (<https://github.com/mipmip/github-admin/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [mipmip](https://github.com/mipmip) - creator and maintainer
