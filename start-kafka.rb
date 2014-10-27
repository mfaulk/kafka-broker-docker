#!/usr/bin/env ruby
require 'socket'
require 'erb'

kafka_home = ENV['KAFKA_HOME']
@local_ip = Socket.ip_address_list.find(&:ipv4_private?).ip_address
@zk_ip = ENV['ZK_PORT_2181_TCP_ADDR'] 
@broker_id = ENV['BROKER_ID']
@port = ENV['PORT']

File.open("#{kafka_home}/config/server.properties", 'w') { |f|
f.write(ERB.new(File.open("#{kafka_home}/config/server.properties.erb").read).result(binding))}

exec("#{kafka_home}/bin/kafka-server-start.sh #{kafka_home}/config/server.properties")
