<cfscript>
    
    myresturl   = "http://" & cgi.server_name & "/rest/" & application.applicationname & "/";
    calls       = {};
    // make a GET call
    // calls.options = xmlParse(new http(url:myresturl & "contacts/",method:"options").send().getPrefix().fileContent ); 


    // make a GET call
    calls.get = deserializeJSON( new http(url:myresturl & "contacts/1.json").send().getPrefix().fileContent ); 

    writeDump(label:"GET 1",var:calls.get);


    // create new contact
    newcontact = {
        "firstname" : "Giancarlo",
        "lastname"  : "Gomez",
        "email"     : "giancarlo.gomez@gmail.com",
        "dob"       : "04/23/1976",
        "phone"     : "305-555-5551",
        "cell"      : "305-666-0777"
    };
    // create http call
    calls.post = new http(url:myresturl & "contacts/create",method:"POST");
    // add param
    calls.post.addParam(type:"formField",name:"contact",value:serializeJSON(newcontact));
    calls.post.addParam(type:"header",name:"Content-Type",value:"application/x-www-form-urlencoded");
    // send and process return
    calls.post = deserializeJSON( calls.post.send().getPrefix().fileContent ); 
    
    writeDump(label:"POST",var:calls.post);


    // make a second GET call
    calls.get = deserializeJSON( new http(url:myresturl & "contacts/1.json").send().getPrefix().fileContent ); 
    writeDump(label:"GET 2",var:calls.get);


    // update existing contact
    thecontact = {
        "id"        : 1,
        "firstname" : "Giancarlo",
        "lastname"  : "Gomez",
        "email"     : "giancarlo.gomez@gmail.com",
        "dob"       : "04/23/1976",
        "phone"     : "305-555-5510",
        "cell"      : "305-666-0777"
    };

    // create http call
    calls.put = new http(url:myresturl & "contacts/update",method:"PUT");
    // add param
    calls.put.addParam(type:"header",name:"Content-Type",value:"application/x-www-form-urlencoded; charset=UTF-8");
    calls.put.addParam(type:"url",name:"contact",value:serializeJSON(thecontact));
    
    // send and process return
    calls.put = deserializeJSON( calls.put.send().getPrefix().fileContent ); 
    writeDump(label:"PUT",var:calls.put);

    // make a third GET call
    calls.get = deserializeJSON( new http(url:myresturl & "contacts/1.json").send().getPrefix().fileContent ); 
    writeDump(label:"GET 3",var:calls.get);

    // delete contact
    // create http call
    calls.delete = deserializeJSON( new http(url:myresturl & "contacts/1",method:"DELETE").send().getPrefix().fileContent ) ;

    
    // show me everything I did
    // writeDump(label:"DELETE",var:calls.delete);

</cfscript>