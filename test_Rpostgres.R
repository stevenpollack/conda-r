library(RPostgres)

pgPassword <- Sys.getenv('DB_ENV_PASSWORD')
pgHost <- Sys.getenv('DB_PORT_5432_TCP_ADDR')
pgUser <- Sys.getenv('DB_ENV_USER')
pgSchema <- Sys.getenv('DB_ENV_SCHEMA')

cat("PG_HOST: ", pgHost, fill=TRUE)
cat("PG_SCHEMA: ", pgSchema, fill=TRUE)
cat("PG_USER: ", pgUser, fill=TRUE)
cat("PG_PASSWORD: ", pgPassword, fill=TRUE)

conn <- dbConnect(Postgres(),
		  host=pgHost,
		  port=5432,
		  user=pgUser,
		  dbname=pgSchema,
		  password=pgPassword)

testSuccess <- FALSE

testTable <- data.frame(x=1)

tryCatch({
  dbWriteTable(conn, name='test_table', value=testTable, overwrite=TRUE)
  query <- dbFetch(dbSendQuery(conn, 'SELECT * FROM test_table'))
  testSuccess <<- identical(query, testTable)
}, error=function(e){
  warning(e[['message']])
  quit("no", status=1)
}, finally={
  suppressWarnings(dbDisconnect(conn))
})

if (!testSuccess) {
  cat("✗ ✗ ✗ Test table and retrieved table weren't equal...")
  quit("no", status=1)
}

cat("✔ ✔ ✔ Everything seems to work...")
quit("no")
