local ui = fu.UIManager
local disp = bmd.UIDispatcher(ui)
local width, height = 600, 75
local clock = os.clock

function sleep(n)  -- seconds
    local t0 = clock()
    while clock() - t0 <= n do end
end

win = disp:AddWindow({
    ID = 'MyWin',
    WindowTitle = 'Import from YouTube',
    Geometry = {100, 100, width, height},
    Spacing = 15,
    Margin = 20,

    ui:VGroup{
        ID = 'root',
        ui:HGroup{
            ui:LineEdit{
                ID = "inputurl",
                PlaceholderText = "Enter a video's URL",
                Text = "",
                Weight = 2,
                MinimumSize = {200, 25}
            },
            ui:Button{
                ID = 'getvidf',
                Text = 'Download Video',
                Weight = 1,
                MinimumSize = {75, 25}
            },
        },
    },
})

itm = win:GetItems()
resolve = Resolve()
projectManager = resolve:GetProjectManager()
project = projectManager:GetCurrentProject()
mediapool = project:GetMediaPool()
folder = mediapool:GetCurrentFolder()
mediastorage = resolve:GetMediaStorage()
mtdvol = mediastorage:GetMountedVolumes()

function win.On.MyWin.Close(ev)
    disp:ExitLoop()
end

function win.On.getvidf.Clicked(ev)
    local url = tostring(itm.inputurl.Text)

    if url == "" then
        ui:MsgBox("Please enter a URL.")
        return
    end

    local pname = project:GetName()
    local ipath = mtdvol[1] .. "\\ytdlp\\" .. pname

    -- Enclose the URL in quotes to handle special characters
    local ytdlcomm = "yt-dlp \"" .. url .. "\" -o \"" .. ipath .. "\\%(title)s.%(ext)s\" --restrict-filenames -S vcodec:h264,res,acodec:aac"

    -- Debugging output
    dump("Executing command: " .. ytdlcomm)

    local success = os.execute(ytdlcomm)
    if not success then
        ui:MsgBox("Download failed.")
        return
    end

    -- Further processing to add all files in the directory to the media pool
    local prelscomm = "dir \"" .. ipath .. "\" /b"
    local prenameproc = assert(io.popen(prelscomm))
    local files = {}

    for line in prenameproc:lines() do
        table.insert(files, line)
    end
    prenameproc:close()

    -- Debugging: Check what files were found
    if #files == 0 then
        dump("No files found in directory: " .. ipath)
        ui:MsgBox("No files found in the output directory.")
        return
    else
        dump("Files found: " .. table.concat(files, ", "))
    end

    -- Add each file to the media storage
    for _, fname in ipairs(files) do
        local fpath = ipath .. "\\" .. fname
        -- Debugging: Check file path before adding
        dump("Adding to media pool: " .. fpath)
        mediastorage:AddItemListToMediaPool(fpath)
    end

    -- Success response
    ui:MsgBox("Download successful: " .. #files .. " files added.")
end

win:Show()
disp:RunLoop()
win:Hide()
