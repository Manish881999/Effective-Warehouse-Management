use warehouse;


db.Customer.find();


db.Distribution_center.aggregate([
  {
    $lookup: {
      from: "Warehouse",
      localField: "warehouse_name",
      foreignField: "warehouse_name",
      as: "supplies_from_warehouse_name",
    },
  }
])
























//db.createCollection("Customer");
//db.createCollection("Distribution_center");
//db.createCollection("Electronics");
//db.createCollection("Employee");
//db.createCollection("Employee_Email");
//db.createCollection("food");
//db.createCollection("Goods");
//db.createCollection("Online_order");
//db.createCollection("Payment");
//db.createCollection("Receives");
//db.createCollection("Sells");
//db.createCollection("Store");
//db.createCollection("supplies_to");
//db.createCollection("works_at");
//db.supplies_to_new.renameCollection("supplies_to")
//db.Test_Table.drop()
//db.Distribution_center.find();

//db.Warehouse.find(
//    {
//        "warehouse_name" : "Doris warehouse"
//    }
//);
//
//db.Distribution_center.aggregate([ 
//  { $match : { warehouse_name : "Doris warehouse" } },
//])
