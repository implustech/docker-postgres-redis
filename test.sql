--
CREATE EXTENSION redis_fdw;
CREATE SERVER redis_server
   FOREIGN DATA WRAPPER redis_fdw
   OPTIONS (address 'redis', port '6379');  -- redis host and port
CREATE USER MAPPING FOR PUBLIC
   SERVER redis_server
   OPTIONS (password '');   --emtpy if no password

-- string
-- mget prop1 prop2
CREATE FOREIGN TABLE redis_db0 (key text, val text)
   SERVER redis_server
   OPTIONS (database '0');
INSERT INTO redis_db0 (key, val)
   VALUES ('prop1','val1'),('prop2','val2');

-- hash value CRUD
-- hgetall mytable
CREATE FOREIGN TABLE myredis_s_hash (key text, val text)
   SERVER redis_server
   OPTIONS (database '0', tabletype 'hash',  singleton_key 'mytable');
INSERT INTO myredis_s_hash (key, val)
   VALUES ('prop1','val1'),('prop2','val2');

-- hash
-- hgetall mytable:r1
CREATE FOREIGN TABLE myredishash (key text, val text[])
    SERVER redis_server
    OPTIONS (database '0', tabletype 'hash', tablekeyprefix 'mytable:');
INSERT INTO myredishash (key, val)
     VALUES ('mytable:r1','{prop1,val1,prop2,val2}');
