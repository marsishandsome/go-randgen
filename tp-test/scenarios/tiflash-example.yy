init: create table t (a int auto_increment, primary key (a));
      set_tiflash_replica;
      insert into t values (1), (2), (3);

set_tiflash_replica:
      alter table t set tiflash replica 1; select sleep(20)

select_tiflash_hint:
      { print("select /*+ read_from_storage(tiflash[t]) */") }

txn: select_tiflash_hint * from t; | insert into t values (0); txn
