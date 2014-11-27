#!/usr/bin/env ruby

require 'rubygems'
require 'thor'
require './generator'
require_relative 'ios_gen/base/view_model'
require_relative 'ios_gen/base/property'
require_relative 'ios_gen/base/action'
require_relative 'ios_gen/base/interactor'


class IOSgen < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc 'spec', 'Generate files with spec file'
  method_option :destination, aliases: '-d', desc: 'destination path'
  method_option :languague, aliases: '-l', desc: 'objc or swift'
  def spec(file_path)
    puts file_path
    file = File.read(file_path)
    hash = JSON.parse(file)
    @view_model = IOSGen::Base::ViewModel.new(hash)

    @viewmodel_name = @view_model.name
    @viewmodel_protocol_name = "#{@viewmodel_name}" + 'Protocol'
    @viewmodel_protocol_delegate = "#{@viewmodel_protocol_name}" + 'Delegate'

    template('../templates/objc/ViewModelProtocol.h.erb', "ViewModels/#{@viewmodel_name}/#{@viewmodel_protocol_name}.h")
    template('../templates/objc/ViewModel.h.erb', "ViewModels/#{@viewmodel_name}/#{@viewmodel_name}.h")
    template('../templates/objc/ViewModel.m.erb', "ViewModels/#{@viewmodel_name}/#{@viewmodel_name}.m")
  end
  # register(Generator, 'screen', 'screen', 'Generate the files to create a new screen')
end

IOSgen.start
