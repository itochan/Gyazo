# encoding: utf-8
# -*- ruby -*-
#
# $Date$
# $Rev$
#
require 'digest/md5'
require 'sdbm'
require "rubygems"
require "rack"
require "pp"

HOST = "http://g.itochan.jp"

class Upload

    def call(env)
        req = Rack::Request.new(env)
        params = req.params()


        res = Rack::Response.new

        id = params['id']

        imagedata = params["imagedata"]
        filename = params["filename"]

        $logger << imagedata.size
        $logger << id

        hash = Digest::MD5.hexdigest(imagedata)

        #dbm = SDBM.open('db/id',0644)
        #dbm[hash] = id
        #dbm.close

        ext = File.extname(filename)

        File.open("data/#{hash}#{ext}", 'w') do |io|
          io.write imagedata
        end

        res.write("#{HOST}/data/#{hash}#{ext}")
        res.finish
    end

end
