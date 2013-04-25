# jenkins_job

Create, test or TDD your Jenkins jobs and parameterized jobs; and then make them dead simple for other people to install.

STATUS: This README describes the goals of the project only.

You can develop Jenkins jobs themselves within Jenkins or within your local editor (currently by editing XML). You can test that your jobs by writing tests in Ruby.

## Usage

`jenkins_job` is a command-line tool to:

* create a project to develop and test one or more Jenkins jobs
* target an existing Jenkins job and write tests for it
* create a new Jenkins job, write tests for it
* install the developed Jenkins jobs into one or more Jenkins servers

It makes it really easy to develop Jenkins jobs and then let other people install them.

### Development

In the example below we create a new project to take an existing, perhaps imperfect, Jenkins job named "Deploy Cloud Foundry App" and creating a test harness for it. Finally we run the initial generated test files. But, you know, you'd probably edit the `deploy_cloud_foundry_app_spec.rb` file and write some tests first.

```
$ jenkins_job new deploy_cloudfoundry_app
    create deploy_cloudfoundry_app-jenkinsjob.gemspec
    create Gemfile
    create README.md
    create Rakefile
    create .travis.yml
    create lib/deploy_cloudfoundry_app/version.rb
    create spec/spec_helper
Running: bundle install...

$ cd deploy_cloudfoundry_app
$ jenkins_job job "Deploy Cloud Foundry App" -j http://user:pass@jenkins.mycompany.com
Looking for job "Deploy Cloud Foundry App"... found.
Downloading job... done.
Discovered the following job parameters:
    cf_env: String
    cf_instances: Integer (default: 1)

    create jobs/deploy_cloud_foundry_app/config.xml
    create spec/config/deploy_cloud_foundry_app.yml
    create spec/integration/deploy_cloud_foundry_app_spec.rb

# Run a local Jenkins server for integration tests
$ rake jenkins:start
$ rake jenkins:wait_til_started

$ rake spec
Downloading latest "Deploy Cloud Foundry App" to jobs/deploy_cloud_foundry_app/config.xml... done.
Running RSpec:

  deploy_cloud_foundry_app
    can build with parameters
```

You can develop, test and package one or more Jenkins jobs.

### Packaging and release

When you are finished you can distribute your Jenkins jobs for others to use using RubyGems.

First, edit `lib/deploy_cloudfoundry_app/version.rb` to increment the versioning.

```
$ rake release
Releasing deploy_cloudfoundry_app-jenkinsjob v1.0.0
```

### Continuous integration

Each project generated from `jenkins_job new` includes a `.travis.yml` for running the test suite within the free https://travis-ci.org/. You only need to set up a [Service Hook on your Git host](http://about.travis-ci.org/docs/user/getting-started/#Step-two%3A-Activate-GitHub-Service-Hook "Travis CI: Getting started").

TODO: How do we support CloudBees' BuildHive?

### Share your job

Other Jenkins users can now download your Jenkins jobs and install them.

```
$ gem install deploy_cloudfoundry_app-jenkinsjob
  installing jenkins_job
  installing deploy_cloudfoundry_app-jenkinsjob

To install "deploy_cloudfoundry_app" to your Jenkins server:

   $ jenkins_job install deploy_cloudfoundry_app -j http://me:mypass@jenkins.coolcompany.com
```

Alternately they can install it from the project source.

```
$ git clone git://github.com/YOURNAME/deploy_cloudfoundry_app-jenkinsjob.git
$ cd deploy_cloudfoundry_app-jenkinsjob
$ bundle install
$ jenkins_job install # install all included jobs
$ jenkins_job install deploy_cloudfoundry_app # install specific job
```

## Dependencies

This tool requires Ruby 1.9 & RubyGems to be installed; and Java 1.6+ installed to use the built-in testing harness (to run Jenkins and test your Jobs)

## Installation

`jenkins_job` is a command-line tool that is packaged & distributed via RubyGems.

Install it:

```
$ gem install jenkins_job
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
