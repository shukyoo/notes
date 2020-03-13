rs.initiate(
   {
      _id: "rs1",
      version: 1,
      members: [
         { _id: 0, host : "rs1_node1:27017" },
         { _id: 1, host : "rs1_node2:27017" }
      ]
   }
)
