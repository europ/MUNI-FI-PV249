# MiniHub

### Prerequisites

1. [rbenv](https://github.com/rbenv/rbenv)
2. [rbenv/ruby-build](https://github.com/rbenv/ruby-build)
3. [ruby](https://github.com/rbenv/ruby-build#usage)
    * version 2.6.4
4. [nodejs](https://nodejs.org/en/download/package-manager/)
5. [yarn](https://yarnpkg.com/lang/en/docs/install)
6. [bundler](https://bundler.io#getting-started)
    * version 2

### Setup

1. Environment check
    ```sh
    # rbenv and ruby
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

    # npm
    npm doctor

    # yarn
    yarn check --verify-tree

    # bundler
    bundle doctor
    ```
2. Dependency installation
    ```sh
    yarn install --check-files
    bundle install
    ```
3. Database creation
    ```sh
    bundle exec rake db:create db:migrate db:seed
    ```
4. [Increase the amount of inotify watchers](https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers) temporary
    ```sh
    sudo sysctl fs.inotify.max_user_watches=524288
    sudo sysctl -p
    ```
5. Launch
    ```sh
    bundle exec rails server
    ```
6. Open http://localhost:3000/
