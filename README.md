# THIS PROJECT HAS BEEN DISCONTINUED

A completely new implementation is been made in [FARMA-ALG-REBORN](https://github.com/rwehresmann/farma_alg_reborn). Take a look!

# Description

Reimplementation of [FARMA-ALG](https://github.com/alexkutzke/farma_alg) originally developed by [Alex Kutzke](https://github.com/alexkutzke).

## Purpose

  * Upgrade the tool to Rails 5;
  * Self-learn;
  * Test coverage;
  * Code refactor.

Everything to promove long-term maintability and keep the project simple and easy to understand.

## Usage

  * Clone the repo;
  * run `bundle install`;
  * Intall Free Pascal Compiler (`sudo apt-get install -y fpc`). It is necessary because some tests call a bash script and compile right and wrong Pascal source codes;
  * Run `rspec`. If none test fails, you are ready to start.

## Whant to contribute?

Good! Follow these steps:

  * Fork the project;
  * Create your branch;
  * Keep your commits organized;
  * Send your pull request (well described, because can be a good referral to other developers).
  
And never forget the project **purpose**! Here its a good guideline to follow:

  * Almost everithing is tested (and never forget to run the test suite);
  * Before put your efforts in the reimplementation of some method, take a look if is used somewhere;
  * A functionality is complex? Try make it simple. Still complex? Be sure to add a comment to help to understand what is happening;
  * Try give self-explanatory names to local variables;
  * In the code, english is the only language (method names, variables, tables, ...).
 
Any problem, try to contact a contributor or open a issue.

