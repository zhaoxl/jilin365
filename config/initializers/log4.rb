require 'log4r'
require 'rubygems'
include Log4r

Log4r::Logger.root.level = Log4r::DEBUG
$log4 = Log4r::Logger.new("log4")
$log4.outputters = Outputter.stdout
file = FileOutputter.new('fileOutputter', :filename => 'log/log4.log',:trunc => false)
$log4.add(file)
$log4.level = Log4r::DEBUG
$log4.trace = true



$log4_scheduler = Log4r::Logger.new("log4_scheduler")
file = FileOutputter.new('fileOutputter', :filename => 'log/log4_scheduler.log',:trunc => false)
$log4_scheduler.add(file)
$log4_scheduler.level = Log4r::DEBUG
$log4_scheduler.trace = true

