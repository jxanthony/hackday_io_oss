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
