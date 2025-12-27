-- KeySystem.lua - FlyyGUI License Validation
-- Upload file ini ke GitHub untuk validasi key

local KeySystem = {}

-- ============================
-- CONFIGURATION
-- ============================
KeySystem.WebhookURL = "https://discord.com/api/webhooks/1454561358560362627/cAf9zb40USewve5cfYvlLztUtUpkQqGOi0sx42iBSY0jASSJhtjw7RQfGX4eurNIXHSQ"
KeySystem.SaveFileName = "FlyyGUI_License.dat"

-- ============================
-- HWID DETECTION
-- ============================
function KeySystem.GetHWID()
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    return hwid
end

-- ============================
-- SAVE/LOAD LICENSE
-- ============================
function KeySystem.SaveLicense(key)
    local success = pcall(function()
        writefile(KeySystem.SaveFileName, key)
    end)
    return success
end

function KeySystem.LoadLicense()
    local success, result = pcall(function()
        return readfile(KeySystem.SaveFileName)
    end)
    if success then
        return result
    end
    return nil
end

function KeySystem.DeleteLicense()
    pcall(function()
        delfile(KeySystem.SaveFileName)
    end)
end

-- ============================
-- KEY VALIDATION VIA WEBHOOK
-- ============================
function KeySystem.ValidateKey(key, hwid)
    local HttpService = game:GetService("HttpService")
    local requestFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    
    if not requestFunc then
        warn("❌ HTTP request function not found!")
        return false, "Executor tidak support HTTP request"
    end
    
    -- Payload untuk Discord webhook
    local payload = {
        embeds = {{
            title = "🔐 FlyyGUI - Key Validation Request",
            description = "User mencoba validasi key",
            color = 3447003,
            fields = {
                {
                    name = "🆔 HWID",
                    value = "```" .. hwid .. "```",
                    inline = false
                },
                {
                    name = "🔑 Key",
                    value = "```" .. key .. "```",
                    inline = false
                },
                {
                    name = "⏰ Time",
                    value = os.date("%m/%d/%Y %H:%M:%S"),
                    inline = false
                }
            },
            footer = {
                text = "FlyyGUI Key System",
                icon_url = "https://i.imgur.com/shnNZuT.png"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    -- Kirim ke Discord
    local success, response = pcall(function()
        return requestFunc({
            Url = KeySystem.WebhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)
    
    if not success then
        return false, "Gagal connect ke server validasi"
    end
    
    -- VALIDASI KEY
    -- Format key: FLYY-XXXX-XXXX (contoh: FLYY-AB12-CD34)
    if not key:match("^FLYY%-%w%w%w%w%-%w%w%w%w$") then
        return false, "Format key salah! Format: FLYY-XXXX-XXXX"
    end
    
    -- Di sini kamu bisa tambah validasi tambahan
    -- Contoh: cek di database, cek whitelist, dll
    
    -- Untuk demo, semua key dengan format benar = valid
    -- GANTI INI dengan sistem validasi kamu sendiri!
    
    return true, "Key valid!"
end

-- ============================
-- CHECK IF ALREADY ACTIVATED
-- ============================
function KeySystem.IsActivated()
    local savedKey = KeySystem.LoadLicense()
    if not savedKey then
        return false
    end
    
    -- Cek apakah key masih valid
    local hwid = KeySystem.GetHWID()
    local isValid, message = KeySystem.ValidateKey(savedKey, hwid)
    
    if not isValid then
        -- Key tidak valid lagi, hapus
        KeySystem.DeleteLicense()
        return false
    end
    
    return true
end

-- ============================
-- ACTIVATE LICENSE
-- ============================
function KeySystem.Activate(key)
    local hwid = KeySystem.GetHWID()
    
    -- Validasi key
    local isValid, message = KeySystem.ValidateKey(key, hwid)
    
    if not isValid then
        return false, message
    end
    
    -- Save license
    local saved = KeySystem.SaveLicense(key)
    if not saved then
        return false, "Gagal save license di perangkat"
    end
    
    -- Send success notification ke Discord
    local HttpService = game:GetService("HttpService")
    local requestFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    
    pcall(function()
        local successPayload = {
            embeds = {{
                title = "✅ FlyyGUI - License Activated!",
                description = "User berhasil aktivasi license",
                color = 3066993,
                fields = {
                    {
                        name = "🆔 HWID",
                        value = "```" .. hwid .. "```",
                        inline = false
                    },
                    {
                        name = "🔑 Key",
                        value = "```" .. key .. "```",
                        inline = false
                    },
                    {
                        name = "👤 Username",
                        value = game.Players.LocalPlayer.Name,
                        inline = true
                    },
                    {
                        name = "🎮 Game",
                        value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                        inline = true
                    }
                },
                footer = {
                    text = "FlyyGUI Key System • Activation Success",
                    icon_url = "https://i.imgur.com/shnNZuT.png"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        
        requestFunc({
            Url = KeySystem.WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(successPayload)
        })
    end)
    
    return true, "License berhasil diaktivasi!"
end

-- ============================
-- GET HWID (for display)
-- ============================
function KeySystem.GetHWIDForDisplay()
    local hwid = KeySystem.GetHWID()
    return hwid
end

return KeySystem
