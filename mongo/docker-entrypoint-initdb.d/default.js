const conn = new Mongo("127.0.0.1:27017");
print(`连接: ${conn}`);

let db = conn.getDB("default_db");
print(`当前数据库：${db}`);

db.createCollection("item");

db.item.insert({"item": "default"});