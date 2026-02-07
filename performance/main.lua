-- Simple benchmarks for various test functions

local TESTS = {
    Math = function()
        local s = 0
        for i = 1, 5000000 do -- loop through 5 million iterations
            s = s + math.sin(i) - math.cos(i)
        end
        return true
    end,

    File = function()
        local file = io.open("ratchet/data/performance.txt", "w")
        file:write("test")
        file:close()

        local file = io.open("ratchet/data/performance.txt", "r")
        local text = file:read()
        file:close()

        return text == "test"
    end,

    JSON = function()
        local saved = JSON.save("ratchet/data/performance.json", {
            message = "Hello world!",
            time = World.GetTimeOfDay(),
            dice = Dice.Roll(2, 6),
            players = getPlayerCount(),
            success = true
        })

        if (not saved) then
            return false, "Failed to write JSON file."
        end

        local data = JSON.load("ratchet/data/performance.json")
        if (not data) then
            return false, "Failed to read JSON file."
        end

        local text = JSON.stringify(data)
        local parsed = JSON.parse(text)
        return parsed and parsed.success
    end,

    Table = function()
        local n = 1000000
        local t = {}
        for i = 1, n do
            t[i] = i
        end

        local sum = 0
        for i = 1, #t do
            sum = sum + t[i]
        end

        local expected = n * (n + 1) / 2
        return sum == expected
    end,

    Concat = function()
        local n = 200000
        local part = "x"
        local t = {}
        for i = 1, n do
            t[i] = part
        end

        local big = table.concat(t)
        return #big == n
    end,

    SQL = function()
        local db = dbConnect("sqlite3", "ratchet/data/performance.db")
        local connected = db:isConnected()
        db:close()
        return connected
    end
}

function runTest(func)
    local start = os.clock()
    local success, error = func()
    local elapsed = os.clock() - start
    if (success) then
        printSuccess(("OK! Elapsed time: %.3fs"):format(elapsed))
    elseif (error) then
        printWarning(("Test failed after %.3fs (Error: %s)"):format(elapsed, error))
    else
        printWarning(("Test failed after %.3fs"):format(elapsed))
    end
end

function runTestDeferred(func, num, total, name)
    printInfo(("Running deferred performance test [%d/%d] - %s"):format(num, total, name))
    runTest(func)
end

function runTests(list, deferred)
    printInfo(("Running %d performance tests (%s)"):format(#list, deferred and "deferred" or "non-deferred"))
    for k, v in ipairs(list) do
        if (deferred) then
            defer(runTestDeferred, TESTS[v], k, #list, v)
        else
            printInfo(("Running performance test [%d/%d] - %s"):format(k, #list, v))
            runTest(TESTS[v])
        end
    end
end

-- run all tests
defer(runTests, table.keys(TESTS), false)
defer(runTests, table.keys(TESTS), true)
