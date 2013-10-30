#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new
conn.start

channel  = conn.create_channel
exchange = channel.topic("topic_logs")
severity = ARGV.shift || "anonymous.info"
msg      = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

exchange.publish(msg, :routing_key => severity)
puts " [x] Sent #{severity}:#{msg}"

conn.close
