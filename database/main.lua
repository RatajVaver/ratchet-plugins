-- this example showcases a database wrapper plugin with some tests
-- in other plugins we can use exports.database.connect() and run queries with it

local db
function getConnection()
    if(not db)then
        db = dbConnect("sqlite3", "data/test.db")
        print("Database connected!")
    end
    return db
end
export("connect", getConnection)

if(getConnection())then
    db:query("SELECT value FROM settings WHERE key = 'motd'", function(success, error, rows)
        print(rows[1].value)
    end)
else
    print("Failed to open database!")
end