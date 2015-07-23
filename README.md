# HACK THIS

## About
- Hack Tracker support & hosting is now owned by the Yammer Internal Services Engineering team. It is hosted on our Hyper-V VMs on Corpnet.
- The postgres server is running on yamsfo220
- The Hack Tracker puma server is running on yamsfo221 (see below on how to get access)
- See the hack tracker at https://hacktracker.corp.microsoft.com.
- hackday.int.yammer.com will also redirect to the above URL

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
  git clone git@github.int.yammer.com:yammer/hackdayio.git
  cd hackdayio
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

### Deploying
1. Request access to the hacktracker server group in [homie2](https://homie2.int.yammer.com) (sub-group is under IT)
2. Once your access is approved, you should be able to ssh into yamsfo221 and login with your LDAP credentials
  ```sh
    ssh yamsfo221
  ```
3. Change directory to the project folder
  ```sh
  cd /var/www/hackdayio
  ```
4. Pull the changes
  ```sh
  git pull origin master
  ```
5. Restart the server
  ```sh
  sudo restart puma-manager
  ```

## Features to add:
- [ ] History of hacks presented in order of queued
- [ ] Select winning hacks (admin only)
- [ ] Allow videos to be added to hacks (or timestamp a longer video)
- [ ] Show judges for a Hack Day
- [ ] Move presentations to a specific spot in the queue
- [ ] Make votes harder to cheat
- [ ] More...
