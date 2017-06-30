# HACK THIS

## About
- Hack Tracker is a rails based application written to ease tracking and ranking hackday projects and presentations. It dedicates authentication and authorization to Github. 

## Dependencies
- Ruby 2.0.0
- Rails 4.0.0
- puma - the Rails server
- postgresql - you'll need a postgres server to test

## Contributing
### Setup
Clone the repo and install dependencies

  ```sh
  cd <your_project_directory>
  git clone git@github.com:Microsoft/hackday_io_oss.git
  cd hackday_io_oss
  bundle install
  ```

  Copy the application.yml.sample file contents located under the config directory and change the values accordingly:

  ```
SECRET_TOKEN: 'a secured token usually obtained by running: rake secrets'
DATABASE_HOST: 'your database backend address, not used in development mode'
DATABASE_USERNAME: 'db_username'
DATABASE: 'db_name'
NEW_RELIC_KEY: 'optional'
GITHUB_KEY: 'the client id obtained after creating an oauth application under your profile setting page in github'
GITHUB_SECRET: 'the client id obtained after creating an oauth application under your profile setting page in github'
GITHUB_URL: 'https://github.com or your private github enterprise address'
GITHUB_API_URL: 'https://api.github.com or your private ghe api endpoint.'

  ```

  *In development mode some directories aren't required but once you do attempt to start the server in production mode, you will need to generate the following file structure:
  -hackday_io_oss (root directory)
  ```
    |- ...
    |- shared
    | |- log
    | |- pids
    | |- sockets
    |
    |- ...
  ```

### Making changes and committing
1. Create a new local branch
  
  ```sh
  git checkout -b branch_name
  ```
2. Make your changes
3. Push your branch to github
  
  ```sh
  git push origin branch_name
  ```
4. Open a pull request
5. Code reviewz   
6. Merge to master



## Features to add:
- [ ] History of hacks presented in order of queued
- [ ] Select winning hacks (admin only)
- [ ] Allow videos to be added to hacks (or timestamp a longer video)
- [ ] Show judges for a Hack Day
- [x] Move presentations to a specific spot in the queue
- [ ] Make votes harder to cheat
- [ ] More...

# Contributing

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
