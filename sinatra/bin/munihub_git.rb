#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'munihub_git'

MunihubGit::App.run!
