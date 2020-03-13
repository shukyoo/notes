rs.initiate(
   {
      _id: "configrs",
      configsvr: true,
      version: 1,
      members: [
         { _id: 0, host : "configsrv:27017" }
      ]
   }
)
