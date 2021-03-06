pg = require('pg');
conString = "postgres://microservices:microservices@microservices.cc9uedlzx2lk.eu-west-1.rds.amazonaws.com/micro";


module.exports.getPreviousData = (callback)->
    pg.connect(conString, (err, client, done) ->
        if(err)
            return console.error('error fetching client from pool', err);

        client.query("SELECT * from facts", (err, result)->
            #call `done()` to release the client back to the pool
            if(err)
                console.error('error running query', err);
                
            callback(result.rows)

            client.end();
        )
    )


    