-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

--[[
# Generates test data for moz_ingest_comman/pioneer decoder
--]]

require "jose"
require "string"

-- RSA 4096 public and private params, without CRT params
local rsa = [[
{
  "kty": "RSA",
  "e": "AQAB",
  "n": "vlbWUA9HUDHB5MDotmXObtE_Y4zKtGNtmPHUy_xkp_fSr0BxNdSOUzvzoAhK3sxTqpzVujKC245RHJ84Hhbl-KDj-n7Ee8EV3nKpnsqiBgHyc3rBpxpIi0J8kYmpiPGXu7k4xnCWCeiu_gfFGzvPdLHzlV7WOfYIHvymtbS7WOyTQLBgDjUKfHdJzH75vogy35h_mEcS-pde-EIi7u4OqD3bNW7iLbf2JVLtSNUYNCMMu23GsOEcBAsdf4QMq5gU-AEFK4Aib8mSPi_tXoohembr-JkzByRAkHbdzoGXssj0EHESt4reDfY8enVo5ACKmzbqlIJ1jmPVV6EKPBPzcQiN9dUA43xei2gmRAswdUKnexVPAPFPfKMpLqr24h1e7jHFBQL23-QqZX-gASbEDiYa9GusSY4kRn80hZRqCq4sgIRVEiu3ofjVdo4YzzESAkmfgFayUThhakqP82_wr9_Uc2vw3ZtlaTC_0LY70ne9yTy3SD3yEOa649nOTBfSh156YGtxvaHHidFojVHpPHBmjGAlak--mONHXHn00l_CVivUcuBqIGcZXRfiO6YwVDH_4ZTVzAkDov1C-4SNJK0XKeIwvGSspaSQrTmH_pT66L7tIhdZLTMVMh2ahnInVZP2G_-motugLq-x962JLQuLLeuh_r_Rk4VHZYhOgoc",
  "kid": "2940921e-3646-451c-8510-971552754e74",
  "d": "oMyvxXcC4icHDQBEGUOswEYabTmWTgrpnho_kg0p5BUjclbYzYdCreKqEPqwdcTcsfhJP0JI9r8mmy2PtSvXINKbhxXtXDdlCEaKMdIySyz97L06OLelrbB_mFxaU4z2iOsToeGff8OJgqaByF4hBw8HH5u9E75cYgFDvaJv29IRHMdkftwkfb4xJIfo6SQbBnbI5Ja22-lhnA4TgRKwY0XOmTeR8NnHIwUJ3UvZZMJvkTBOeUPT7T6OrxmZsqWKoXILMhLQBOyfldXbjNDZM5UbqSuTxmbD_MfO3xTwWWQXfIRqMZEpw1XRBguGj4g9kJ82Ujxcn-yLYbp08QhR0ijBY13HzFVMZ2jxqckrvp3uYgfJjcCN9QXZ6qlv40s_vJRRgv4wxdDc035eoymqGQby0UnDTmhijRV_-eAJQvdl3bv-R5dH9IzhxoJA8xAqZfVtlehPuGaXDAsa4pIWSg9hZkMdDEjW15g3zTQi3ba8_MfmnKuDe4GXYBjrH69z7epxbhnTmKQ-fZIxboA9sYuJHj6pEGT8D485QmrnmLjvqmQUzcxnpU6E3awksTp_HeBYLLbmrv4DPGNyVri2yPPTTRrNBtbWkuvEGVnMhvL2ed9uqLSnH8zOfgWqstqjxadxKADidYEZzmiYfEjYTDZGd9VDIUdKNGHWGFRB7UE",
  "p": "6VtjaNMD_VKTbs7sUQk-qjPTn6mCI8_3loqrOOy32b1G0HfIzCijuV-L7g7RxmMszEEfEILxRpJnOZRehN8etsIEuCdhU6VAdhBsBH5hIA9ZtX8GIs0sPrhc4kzPiwJ6JcLytUc6HCTICf2FIU7SI8I17-p53d35VItYiC1sGLZ2yN61VoKYNTncUSwboP2zXmGv4FPB5wQogryA_bEn-1U12FFSRd75Ku9GAEVxbTk3OaQqYgqfo9LnAWvunTDu31D4uyC6rze77NCo8UguqCpFjvF0ihOryQI6C3d0e8kxcM1vJbMvZNfrDN65btzqWi4m-CnqGYkl6BXQtS5UVw",
  "q": "0M7h_gtxoVoNPLRjYA5zBUD8qmyWiAzjloFOrDRLJwiD4OPHgImUx2WPTiSCjouvGqwfJh1jEEryJV_d0e4iVGyKYbFeXfzadwYXXR2jK4QwO1V_JDHI7HUYwNl6qzZqATi2zNKunPgIwY55gWBKjP2aUvPUBAcTeCsUPvrN_SajPVfc2wSlA2TvEnjmweNvgSTNqtBlMpmpwvEb9WXfv4pl3BfRvoTk3VR4icyvl-PLFedp2y0Fs0aQ4LRQ2ZMKWyGQEam_uAoa1tXrRJ_yQRvtWm1K8GpRZGKwN3TvtAg649PxQ7tJ8cvh3BwQROJyQBZDrlR04wqvDK4SNezlUQ"
}]]
local jwk = jose.jwk_import(rsa)

local envelope = [[
{
      "id": "0055FAC4-8A1A-4FCA-B380-EBFDC8571A01",
      "creationDate": "2015-11-05T01:25:43.312Z",
      "type": "pioneer-study",
      "version": 4,
      "application": {
        "architecture": "x86-64",
        "buildId": "20151103030248",
        "channel": "beta",
        "name": "Firefox",
        "platformVersion": "45.0",
        "vendor": "Mozilla",
        "version": "45.0",
        "displayVersion": "45.0b6",
        "xpcomAbi": "x86_64-gcc3"
      },
      "payload" : {
        "encryptedData": "%s",
        "encryptionKeyId": "%s",
        "pioneerId": "11111111-1111-1111-1111-111111111111",
        "studyName": "%s",
        "schemaName": "%s",
        "schemaVersion": %d
      }
}
}]]


local submissions = {
    {'{ "eventId" : "enrolled"}', 'pioneer-20170901', "test-study", "event", 1}, -- valid
    {'text', 'pioneer-20170901', "test-study", "event", 1}, -- parse failure
    {'{ "eventId" : 1}', 'pioneer-20170901', "test-study", "event", 1}, -- study schema validation error
    {'{ "eventId" : "foobar"}', 'pioneer-20200901', "test-study", "event", 1}, -- no encryption key
    {'{ "eventId" : "foobar"}', 'pioneer-20170901', "test-study", "bogus", 1}, -- no schema
    {'{ "eventId" : "foobar"}', 'pioneer-20170901', "test-study", "event", 2}, -- no version
    {[[{"version": 3,
        "study_name": "test-study",
        "branch": "control",
        "addon_version": "0.1.1",
        "shield_version": "1.2.3",
        "testing": true,
        "type": "shield-study",
        "data": {
          "study_state": "ineligible"
        }
       }]], 'pioneer-20170901', "test-study", "shield-study", 3},
}

local msg = {
    Logger = "moz_ingest",
    Type   = "telemetry.raw",
    Hostname = "test.pioneer.com",
    Fields = {
        ["X-Forwarded-For"]         = "127.0.0.1, 216.160.83.56",
        ["X-PingSender-Version"]    = "1.0",
        Host    = "incoming.telemetry.mozilla.org",
        DNT     = "1",
        Date    = "Wed, 30 Aug 2017 20:43:39 GMT",
        content = nil,
        uri     = nil,
    }
}

local uri_template = "/submit/telemetry/0055FAC4-8A1A-4FCA-B380-EBFDC8571A%02d/pioneer-study/Firefox/45.0/release/20151103030248"
local hdr = jose.header({alg = "RSA-OAEP", enc = "A256GCM", zip = "DEF"})
function process_message()
    local cnt = 0
    for i,v in ipairs(submissions) do
        msg.Fields.uri = string.format(uri_template, i)
        local jwe = jose.jwe_encrypt(jwk, v[1], hdr)
        msg.Fields.content = string.format(envelope, jwe:export(), v[2], v[3], v[4], v[5])
        inject_message(msg)
        if i == 1 then inject_message(msg) end -- test duplicate
        cnt = cnt + 1
    end

    -- invalid envelope
    cnt = cnt + 1
    msg.Fields.uri = string.format(uri_template, cnt)
    msg.Fields.content = ""
    inject_message(msg)

    -- invalid envelope schema
    cnt = cnt + 1
    msg.Fields.uri = string.format(uri_template, cnt)
    msg.Fields.content = "{}"
    inject_message(msg)

    local v = submissions[1]
    -- invalid import
    cnt = cnt + 1
    msg.Fields.uri = string.format(uri_template, cnt)
    msg.Fields.content = string.format(envelope, "xxxxxxxxxxxxxxxx", v[2], v[3], v[4], v[5])
    inject_message(msg)

    -- invalid encryption
    cnt = cnt + 1
    msg.Fields.uri = string.format(uri_template, cnt)
    local jwe = jose.jwe_encrypt(jwk, submissions[1][1], hdr)
    msg.Fields.content = string.format(envelope, string.gsub(jwe:export(), "...$", "oqX"), v[2], v[3], v[4], v[5])
    inject_message(msg)

    return 0
end
