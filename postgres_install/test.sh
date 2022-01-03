#!/bin/bash
#!/bin/sh
export HOST=localhost
psql -U postgres -h $HOST -p 5432 -d postgres
