# encoding: utf-8
# -*- ruby -*-
#
# $Date$
# $Rev$
#
require 'cgi'
require 'digest/md5'
require 'sdbm'
require "rubygems"
require "rack"
require "pp"

class Upload

    def call(env)
        req = Rack::Request.new(env)
        cgi = CGI.new("html3")
        params = req.params()


        res = Rack::Response.new

        id = params['id']

        imagedata = params["imagedata"]

        $logger << imagedata.size
        $logger << id

#        id = cgi.params['id'][0].read
#        id - req[]
#        imagedata = cgi.params['imagedata'][0].read
        hash = Digest::MD5.hexdigest(imagedata)

        #dbm = SDBM.open('db/id',0644)
        #dbm[hash] = id
        #dbm.close

        File.open("data/#{hash}.png", 'w') do |io|
          io.write imagedata
        end

        res.write("http://gyazo.gijutsuya.jp/data/#{hash}.png")
#        cgi.out { "http://gyazo.com/#{hash}.png" }
        #
        res.finish
    end

end
